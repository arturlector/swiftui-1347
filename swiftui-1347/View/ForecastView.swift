//
//  ForecastView.swift
//  swiftui-1347
//
//  Created by Artur Igberdin on 02.11.2021.
//

import SwiftUI
import ASCollectionView
import KingfisherSwiftUI

struct ForecastView: View {
    //    Заменяем данную строку
    //    @State var weathers = [Weather]()
    //    На следующую:
    @ObservedObject var viewModel: ForecastViewModel
    
    //    Добавляем инъекцию viewModel в инициализатор, чтобы не забывать про SOLID
    init(viewModel: ForecastViewModel) {
        self.viewModel = viewModel
    }
    //    Дальнейший код сокращен
    var body: some View {
        ASCollectionView(data: viewModel.detachedWeathers) { (weather, context) in
            WeatherView(weather: weather)
        }.layout {
            .grid(
                layoutMode: .fixedNumberOfColumns(2),
                itemSpacing: 0,
                lineSpacing: 16)
        }
        .onAppear(perform: viewModel.fetchForecast)
        .navigationBarTitle(viewModel.city.name)
    }
 }

struct WeatherView: View {
    let weather: Weather
    
    init(weather: Weather) {
        self.weather = weather
    }
    
    var body: some View {
        return GeometryReader { proxy in
            VStack {
                Text(String(format: "%.0f℃", self.weather.temperature))
                KFImage(self.weather.iconUrl)
                    .cancelOnDisappear(true)
                Text(DateFormatter.forecastFormat(for: self.weather.date))
                    .frame(width: proxy.size.width)
            }
        }
    }
}

//struct ForecastView_Previews: PreviewProvider {
//    static var previews: some View {
//        ForecastView()
//    }
//}
