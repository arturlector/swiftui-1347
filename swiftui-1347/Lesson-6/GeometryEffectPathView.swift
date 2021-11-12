//
//  GeometryEffectPathView.swift
//  swiftui-1347
//
//  Created by Artur Igberdin on 09.11.2021.
//

import SwiftUI

struct FollowPathEffect: GeometryEffect {
    
    var percent: CGFloat = 0
    let path: Path
    
    var animatableData: CGFloat {
        get { return percent }
        set { percent = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        let percentPoint = percentPoint(percent)
        
        return ProjectionTransform(CGAffineTransform(translationX: percentPoint.x, y: percentPoint.y))
    }
    
    func percentPoint(_ percent: CGFloat) -> CGPoint {
        let difference: CGFloat = 0.001
        let bound: CGFloat = 1 - difference
        
        let percent = max(min(percent, 1), 0)
        
        let start = percent > bound ? bound : percent
        let finish = percent > bound ? 1 : percent + difference
        let trimmedPath = path.trimmedPath(from: start, to: finish)
        
        return CGPoint(x: trimmedPath.boundingRect.midX, y: trimmedPath.boundingRect.midY)
    }
}


struct GeometryEffectPathView: View {
    @State var percent: CGFloat = 0
    
    var body: some View {
        GeometryReader { proxy in
            Text("Hello, World")
                .background(Color.green)
                .modifier(FollowPathEffect(percent: self.percent, path: Path(ellipseIn: CGRect(origin: .zero, size: proxy.size))))
                .onAppear {
                    withAnimation(Animation.linear(duration: 4.0).repeatForever(autoreverses: false)) {
                        self.percent = 1
                    }
                }
        }
    }
}
