//
//  CitiesView.swift
//  swiftui-1347
//
//  Created by Artur Igberdin on 26.10.2021.
//

import SwiftUI
import ASCollectionView

class City: Identifiable {
   
    internal init(name: String, imageName: String) {
       self.name = name
       self.imageName = imageName
   }
  
   let id: UUID = UUID()
   let name: String
   let imageName: String
}

struct CitiesView: View {
    
    @State private var cities: [City] = [
           City(name: "Kazan", imageName: "kazan"),
           City(name: "Cheboksary", imageName: "cheboksary"),
           City(name: "Vladivostok", imageName: "vladivostok"),
           City(name: "Yaroslavl", imageName: "yaroslavl")
       ]
    
    var body: some View {
        
        
        ASCollectionView(data: cities) { city, _ in
            
            Text("City \(city.name)")
        }.layout {
            .grid(
                layoutMode: .fixedNumberOfColumns(2),
                itemSpacing: 0,
                lineSpacing: 16)
        }.navigationBarTitle(cities[0].name)
        
//        List(cities.sorted(by: { $0.name < $1.name })) { city in
//            Text("City \(city.name)")
//        }
    
    }
}

struct CitiesView_Previews: PreviewProvider {
    static var previews: some View {
        CitiesView()
    }
}
