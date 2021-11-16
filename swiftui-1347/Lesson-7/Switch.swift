//
//  Switch.swift
//  swiftui-1347
//
//  Created by Artur Igberdin on 12.11.2021.
//

import SwiftUI

struct Switch: UIViewRepresentable {
    
    @Binding var isOn: Bool
    
    func makeCoordinator() -> Coordinator {
        Coordinator(isOn: self.$isOn)
    }
    
    func makeUIView(context: Context) -> UISwitch {
        
        let uiSwitch = UISwitch()
        uiSwitch.addTarget(
            context.coordinator,
            action: #selector(Coordinator.updateSwitchStatus(sender:)),
            for: .valueChanged
        )
        
        return uiSwitch
    }
    
    func updateUIView(_ uiSwitch: UISwitch, context: Context) {
        uiSwitch.isOn = isOn
    }
    
    class Coordinator {

        @Binding var isOn: Bool
 
        init(isOn: Binding<Bool>) {
            self._isOn = isOn
        }
        
        @objc func updateSwitchStatus(sender: UISwitch) {
            self.isOn = sender.isOn
        }
    }
}


