//
//  ClockView.swift
//  swiftui-1347
//
//  Created by Artur Igberdin on 09.11.2021.
//

import SwiftUI

struct ClockView: View {
    @State private var time: ClockTime = ClockTime.zero
    
    var body: some View {
        VStack {
            ClockShape(clockTime: time)
                .stroke(Color.blue, lineWidth: 3)
                .padding(20)
                .animation(Animation.linear(duration: 2 * 3600 + 2 * 60 + 2))
                .frame(width: 200, height: 200)
        }.onAppear {
            self.time = ClockTime(hours: 10, minutes: 10, seconds: 30)
        }
    }
}


