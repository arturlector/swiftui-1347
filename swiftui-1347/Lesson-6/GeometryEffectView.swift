//
//  GeometryEffectView.swift
//  swiftui-1347
//
//  Created by Artur Igberdin on 09.11.2021.
//

import SwiftUI



//struct RotationTransformEffect: GeometryEffect {
//
//    var rotation: CGFloat
//    var shift: CGFloat
//
//    var animatableData: AnimatablePair<CGFloat, CGFloat> {
//        get { AnimatablePair(rotation, shift) }
//        set {
//            rotation = newValue.first
//            shift = newValue.second
//        }
//    }
//
//    func effectValue(size: CGSize) -> ProjectionTransform {
//        let rotationTransform = CGAffineTransform(rotationAngle: rotation)
//        let shiftRotationTransform = CGAffineTransform(translationX: shift, y: 0).concatenating(rotationTransform)
//        return ProjectionTransform(shiftRotationTransform)
//    }
//}

struct RotationTransformEffect: GeometryEffect {
    
    var rotation: CGFloat
    var shift: CGFloat
    
    @Binding var isFlipped: Bool
    
    var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(rotation, shift) }
        set {
            rotation = newValue.first
            shift = newValue.second
        }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        
        DispatchQueue.main.async {
            self.isFlipped = self.rotation >= .pi/2
        }
        
        let rotationTransform = CGAffineTransform(rotationAngle: rotation)
        let shiftRotationTransform = rotationTransform.concatenating(CGAffineTransform(translationX: shift, y: 0))
        
        return ProjectionTransform(shiftRotationTransform)
    }
}

/*
struct GeometryEffectView: View {
    
    @State var shift: CGFloat = 0
    @State var rotation: CGFloat = 0
    
    var body: some View {
        HStack {
            Spacer()
            Text("Hello, world!")
                .background(Color.green)
                .modifier(RotationTransformEffect(rotation: rotation, shift: shift))
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 2.0).repeatForever()) {
                        self.rotation = .pi
                        self.shift = 100
                    }
                }
        }
    }
}
*/

struct GeometryEffectView: View {
    
    @State var shift: CGFloat = 0
    @State var rotation: CGFloat = 0
    @State var isFlipped = false
    @State var text = ""
    
    var body: some View {
        let binding = Binding<Bool>(get: { self.isFlipped }, set: { self.updateBinding($0) })
        
        HStack {
            Spacer()
            Text(text)
                .background(Color.green)
                .modifier(RotationTransformEffect(rotation: rotation, shift: shift, isFlipped: binding).ignoredByLayout())
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 2.0).repeatForever()) {
                        self.rotation = .pi
                        self.shift = 100
                    }
                }
        }
    }
    
    func updateBinding(_ value: Bool) {
        if isFlipped != value {
            self.text = isFlipped ? "Hello, from Austria" : "Hello, from Australia"
        }
        
        isFlipped = value
    }
}


