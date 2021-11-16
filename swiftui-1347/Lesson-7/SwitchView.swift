//
//  SwitchView.swift
//  swiftui-1347
//
//  Created by Artur Igberdin on 12.11.2021.
//

import SwiftUI

struct SwitchView: View {
    
    @State var isOn = false
    
    var body: some View {
        VStack {
            Spacer()
            Text(isOn ? "Switch is On" : "Switch is Off")
            Spacer()
            Switch(isOn: $isOn)
            
            Button {
                self.isOn.toggle()
            } label: {
                Text("Press me to change")
            }
            Spacer()
        }
    }
}




