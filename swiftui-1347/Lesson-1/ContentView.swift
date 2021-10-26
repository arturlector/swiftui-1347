//
//  ContentView.swift
//  swiftui-1347
//
//  Created by Artur Igberdin on 20.10.2021.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State var shouldShowCitiesView: Bool = false
    
    var body: some View {
        
//        LoginView(shouldShowCitiesView: $shouldShowCitiesView)
//            .sheet(isPresented: $shouldShowCitiesView, content: {
//                CitiesView()
//            })
        
        NavigationView {
            HStack {
                LoginView(shouldShowCitiesView: $shouldShowCitiesView)
                NavigationLink(destination: CitiesView(), isActive: $shouldShowCitiesView) {
                    EmptyView()
                }
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
