//
//  CitiesView.swift
//  swiftui-1347
//
//  Created by Artur Igberdin on 26.10.2021.
//

import SwiftUI
import ASCollectionView

//class City: Identifiable {
//   
//    internal init(name: String, imageName: String) {
//       self.name = name
//       self.imageName = imageName
//   }
//  
//   let id: UUID = UUID()
//   let name: String
//   let imageName: String
//}

struct CitiesView: View {
    
    @State private var showingAddCityModal: Bool = false
    
    @FetchRequest(entity: City.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \City.name, ascending: false)], predicate: nil, animation: .easeInOut) var cities: FetchedResults<City>
    
    @Environment(\.managedObjectContext) var managedObjectContext
    
    private let weatherService = NetworkService()
    private let realmService = RealmService()
    
    
    var body: some View {
        
        List(cities) { city in
            
            NavigationLink(destination: ForecastView(viewModel: ForecastViewModel(city: city, weatherService: self.weatherService, realmService: self.realmService))) {
                CityView(city: city)
            }
        }
        .navigationBarTitle("Cities", displayMode: .inline)
        .navigationBarItems(trailing: Button(action: { self.showingAddCityModal.toggle() },
                                             label: { Image(systemName: "plus") }))
            .sheet(isPresented: $showingAddCityModal) {
                
                AddCityView().environment(\.managedObjectContext, self.managedObjectContext)
                
            }
    }
}

struct CityView: View {
    let city: City
    
    var body: some View {
        HStack {
            Image(city.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 100, height: 100, alignment: .leading)
                .padding()
            Text(city.name)
        }
    }
}

struct AddCityView: View {
    @Environment(\.presentationMode) var presentation
    @Environment(\.managedObjectContext) var managedObjectContext
    @State var cityname: String = ""
    
    private let screenWidth = UIApplication.shared.windows.filter { $0.isKeyWindow }.first?.frame.width ?? 0
    
    var body: some View {
        VStack(spacing: 12) {
            Text("Add new city:")
            TextField("name", text: $cityname).textFieldStyle(RoundedBorderTextFieldStyle()).frame(width: screenWidth/3)
            HStack(spacing: 0) {
                Button("Ok") {
                    try? City.create(in: self.managedObjectContext, name: self.cityname, imageName: nil)
                    self.presentation.wrappedValue.dismiss()
                }
                .frame(width: screenWidth/6)
                .disabled(cityname.isEmpty)
                
                Button("Cancel") {
                    self.presentation.wrappedValue.dismiss()
                }
                .frame(width: screenWidth/6)
            }
        }
    }
}

//struct CitiesView_Previews: PreviewProvider {
//    static var previews: some View {
//        CitiesView()
//    }
//}
