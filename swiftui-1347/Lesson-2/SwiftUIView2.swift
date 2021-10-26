//
//  SwiftUIView2.swift
//  swiftui-1347
//
//  Created by Artur Igberdin on 22.10.2021.
//

import SwiftUI

@resultBuilder
struct StringBuilder {
    static func buildBlock(_ components: String...) -> String {
        components.joined(separator: "")
    }
    
//    static func buildArray(_ components: [String]) -> String {
//        components.joined(separator: "")
//    }
//    
//    static func buildOptional(_ component: String?) -> String {
//        return component ?? ""
//    }
    
}

struct SwiftUIView2: View {
    var body: some View {
        
        Text(self.stringBuilder())
    }
    
    @StringBuilder func stringBuilder() -> String {
        "Hello"
        "World"
        "Kazan"
        "SPB"
        "NN"
    }
}



//MARK: - Custom View Modifier
struct CustomViewModifier: View {
    var body: some View {
        
        HStack {
            Image("sun")
                .circleColor(.orange)
                .background (
                    Circle()
                        .fill(Color.red)
                        .frame(width:200, height: 200)
                )
            

        }
        .frame(width: 375, height: 100)
       
    }
}


extension View {
    func circleColor(_ color: Color) -> some View {
        self.modifier(CircleColorModifier(color: color))
    }
}

struct CircleColorModifier: ViewModifier {
    let color: Color
    
    func body(content: Content) -> some View {
        content
            .background (
                Circle()
                    .fill(color)
                    .frame(width: 100, height: 100)
            )
            .debug()
    }
}

struct SwiftUIView2_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView2()
    }
}

//MARK: - Alignment Guide
struct AlignmentGuide: View {
    var body: some View {
        
        ZStack() {
            Text("Прогноз погоды")
                //.layoutPriority(1)
                .border(Color.red)
                .alignmentGuide(VerticalAlignment.center, computeValue: { $0[.bottom] })
                .alignmentGuide(HorizontalAlignment.center, computeValue: { $0[.trailing] })
                
               
            
            Image("sun")
                .resizable()
                .border(Color.red)
                .frame(width: 100, height: 100)
                .alignmentGuide(VerticalAlignment.center, computeValue: { $0[.bottom] })
                .alignmentGuide(HorizontalAlignment.center, computeValue: { $0[.leading] })
            
            Text("Прекрасная погода на улице. Прекрасный день dfasdfsdf")
                .multilineTextAlignment(.center)
                .border(Color.red)
                .fixedSize(horizontal: false, vertical: true)
                .alignmentGuide(VerticalAlignment.center, computeValue: { $0[.top] })
        }
            
    }
}

struct WeatherView: View {
    var body: some View {
        Image("sun")
            .border(Color.red)
            //.frame(width: 10, height: 200)
            .padding()
            .border(Color.blue)
            .debug()
           
            
    }
}

extension View {
    func debug() -> some View {
        print(Mirror(reflecting: self).subjectType)
        return self
    }
}

