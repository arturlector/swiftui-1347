//
//  ActivityView.swift
//  swiftui-1347
//
//  Created by Artur Igberdin on 12.11.2021.
//

import SwiftUI

struct ActivityView: View {
    
    @State var isAnimation = true
    
    var body: some View {
       
        ActivityIndicator(style: .large, isAnimation: $isAnimation)
            
            .onTapGesture {
                self.isAnimation.toggle()
        }
        
        
    }
}

