//
//  ClockTime.swift
//  swiftui-1347
//
//  Created by Artur Igberdin on 09.11.2021.
//

import SwiftUI

struct ClockTime {
    
    var hours: Int
    var minutes: Int
    var seconds: Double
    
    // Initializer with hour, minute and seconds
    init(hours: Int, minutes: Int, seconds: Double) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
    
    // Initializer with total of seconds
    init(totalSeconds: Double) {
        let hours = Int(totalSeconds) / 3600
        let minutes = (Int(totalSeconds) - (hours * 3600)) / 60
        let seconds = totalSeconds - Double((hours * 3600) + (minutes * 60))
        
        self.init(hours: hours, minutes: minutes, seconds: seconds)
    }
    
    // compute number of seconds
    var totalSeconds: Double {
        return Double(self.hours * 3600 + self.minutes * 60) + self.seconds
    }
}

extension ClockTime: VectorArithmetic {
    static func -= (lhs: inout ClockTime, rhs: ClockTime) {
        lhs = lhs - rhs
    }
    
    static func - (lhs: ClockTime, rhs: ClockTime) -> ClockTime {
        return ClockTime(totalSeconds: lhs.totalSeconds - rhs.totalSeconds)
    }
    
    static func += (lhs: inout ClockTime, rhs: ClockTime) {
        lhs = lhs + rhs
    }
    
    static func + (lhs: ClockTime, rhs: ClockTime) -> ClockTime {
        return ClockTime(totalSeconds: lhs.totalSeconds + rhs.totalSeconds)
    }
    
    mutating func scale(by rhs: Double) {
        var seconds = Double(self.totalSeconds)
        seconds.scale(by: rhs)
        
        let clockTime = ClockTime(totalSeconds: seconds)
        self.hours = clockTime.hours
        self.minutes = clockTime.minutes
        self.seconds = clockTime.seconds
    }
    
    var magnitudeSquared: Double {
        1
    }
    
    static var zero: ClockTime {
        return ClockTime(hours: 0, minutes: 0, seconds: 0)
    }
}

struct ClockShape: Shape {
    var clockTime: ClockTime
    
    var animatableData: ClockTime {
        get { clockTime }
        set { clockTime = newValue }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let radius = min(rect.size.width / 2.0, rect.size.height / 2.0)
        let center = CGPoint(x: rect.size.width / 2.0, y: rect.size.height / 2.0)
        
        let hoursArrowLength = Double(radius) * 0.5
        let minutesArrowLength = Double(radius) * 0.7
        let secondsArrowLength = Double(radius) * 0.9
        
        let hoursArrowAngle: Angle = .degrees(Double(clockTime.hours) / 12 * 360 - 90)
        let minuteArrowAngle: Angle = .degrees(Double(clockTime.minutes) / 60 * 360 - 90)
        let secondsArrowAngle: Angle = .degrees(Double(clockTime.seconds) / 60 * 360 - 90)
        
        let hoursArrowEnd = CGPoint(x: center.x + CGFloat(cos(hoursArrowAngle.radians) * hoursArrowLength), y: center.y + CGFloat(sin(hoursArrowAngle.radians) * hoursArrowLength))

        let minutesArrowEnd = CGPoint(x: center.x + CGFloat(cos(minuteArrowAngle.radians) * minutesArrowLength), y: center.y + CGFloat(sin(minuteArrowAngle.radians) * minutesArrowLength))

        let secondsArrowEnd = CGPoint(x: center.x + CGFloat(cos(secondsArrowAngle.radians) * secondsArrowLength), y: center.y + CGFloat(sin(secondsArrowAngle.radians) * secondsArrowLength))
        
        path.addArc(center: center, radius: radius, startAngle: .degrees(0), endAngle: .degrees(360), clockwise: true)

        path.move(to: center)
        path.addLine(to: hoursArrowEnd)
        path = path.strokedPath(StrokeStyle(lineWidth: 3.0))

        path.move(to: center)
        path.addLine(to: minutesArrowEnd)
        path = path.strokedPath(StrokeStyle(lineWidth: 3.0))

        path.move(to: center)
        path.addLine(to: secondsArrowEnd)
        path = path.strokedPath(StrokeStyle(lineWidth: 1.0))
        
        return path
    }
}
