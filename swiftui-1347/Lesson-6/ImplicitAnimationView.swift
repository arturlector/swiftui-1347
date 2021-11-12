//
//  ImplicitAnimationView.swift
//  swiftui-1347
//
//  Created by Artur Igberdin on 09.11.2021.
//

import SwiftUI

struct ImplicitAnimationView: View {
    
    @State private var isScaled = false
    @State private var isRotated = false
    @State private var isAnimationOn = false
    
    var body: some View {
        Image("pikachu")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding()
            .scaleEffect(isScaled ? 1.5 : 0.25)
            .rotationEffect(isRotated ? Angle.degrees(180) :  .zero)
            //Неявная анимация (Скрытая)
            //.animation(.easeInOut(duration: 1.0), value: isAnimationOn)
            .onTapGesture {
                self.isRotated.toggle()
//                self.isScaled.toggle()
//                self.isAnimationOn.toggle()
                //Явная анимация
                withAnimation(.easeInOut(duration: 1.0)) {
                    //self.isRotated.toggle()
                    self.isScaled.toggle()
                    self.isAnimationOn.toggle()
                }
            }
    }
}


