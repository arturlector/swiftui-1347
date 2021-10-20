//
//  ContentView.swift
//  swiftui-1347
//
//  Created by Artur Igberdin on 20.10.2021.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    @State var login: String = ""
    @State var password: String = ""
    @State private var shouldShowLogo: Bool = true
    
    private let keyboardIsOnPublisher = Publishers.Merge(
          NotificationCenter.default.publisher(for: UIResponder.keyboardWillChangeFrameNotification)
              .map { _ in true },
          NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)
              .map { _ in false }
      )
    .removeDuplicates()
    .eraseToAnyPublisher()

    
    var body: some View {
        
        ZStack {
            
            GeometryReader { geomerty in
                Image("sunny-weather")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea(.all)
                    .frame(width: geomerty.size.width, height: geomerty.size.height)
            }
            .ignoresSafeArea(.keyboard, edges: .all)
            
            
            ScrollView() {
                VStack {
                    
                    if shouldShowLogo {
                      Text("Weather App ")
                          .font(.largeTitle)
                          .padding(.top, 32)
                   }
                    
                    HStack {
                        //Spacer()
                        Text("Login:")
                        Spacer()
                        TextField("Enter email", text: $login)
                            .frame(maxWidth: 150)
                    }
                    
                    HStack {
                        //Spacer()
                        Text("Password:")
                        Spacer()
                        SecureField("Enter password", text: $password)
                            .frame(maxWidth: 150)
                            
                    }
                    
                    Button(action: {
                        print("Hello")
                    }, label: {
                        Text("Log in")
                    })
                    .padding()
                    .accentColor(.white)
                    .disabled(self.login.isEmpty || self.password.isEmpty)
                    
                    
                    Spacer()
                }
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: 250)
                .padding()
            }.onReceive( keyboardIsOnPublisher , perform: { isKeyboardShow in
                
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.shouldShowLogo = !isKeyboardShow
                }

            })
            //.background(Image("sunny-weather").resizable().ignoresSafeArea(.all).scaledToFill())
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
    }
}

extension UIApplication {
    func endEditing() {
        self.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
