//
//  ActivityIndicator.swift
//  swiftui-1347
//
//  Created by Artur Igberdin on 12.11.2021.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
    
    let style: UIActivityIndicatorView.Style
    
    @Binding var isAnimation: Bool
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let view = UIActivityIndicatorView(style: self.style)
        return view
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
        if isAnimation {
            uiView.startAnimating()
        } else {
            uiView.stopAnimating()
        }
    }
    
    static func dismantleUIView(_ uiView: UIActivityIndicatorView, coordinator: ()) {
        uiView.stopAnimating()
    }
    
}
