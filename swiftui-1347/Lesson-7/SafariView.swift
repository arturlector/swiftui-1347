//
//  SafariView.swift
//  swiftui-1347
//
//  Created by Artur Igberdin on 12.11.2021.
//

import SwiftUI
import UIKit
import SafariServices

struct ContentViewWithController: View {
    
    @State private var showSafari = false
    
    var body: some View {
        VStack {
            if showSafari {
                SafariView(url: URL(string: "https://www.gb.ru")!, showing: $showSafari)
            } else {
                Button("Show Safari View") {
                    self.showSafari = true
                }
            }
        }
    }
}

struct SafariView: UIViewControllerRepresentable {
    
    let url: URL
    @Binding var showing: Bool
        
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariController = SFSafariViewController(url: url)
        safariController.delegate = context.coordinator
        return safariController
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {

    }
    
    func makeCoordinator() -> SafariView.Coordinator {
        return Coordinator(safariView: self)
    }
    
    class Coordinator: NSObject, SFSafariViewControllerDelegate {
        let safariView: SafariView

        init(safariView: SafariView) {
            self.safariView = safariView
        }
        
        func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
            self.safariView.showing = false
        }
    }
}
