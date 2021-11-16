//
//  LoginView.swift
//  swiftui-1347
//
//  Created by Artur Igberdin on 26.10.2021.
//

import SwiftUI
import Combine

class LoginViewModel: ObservableObject {
    @Published var isUserLoggedIn = false
}

struct LoginView: View {
    
// .... код пропущен
    @ObservedObject var viewModel: LoginViewModel

    //@Binding var shouldShowCitiesView: Bool
    
    @State var login: String = ""
    @State var password: String = ""
    @State private var shouldShowLogo: Bool = true
    @State private var showIncorrectCredentialsWarning = false
    
   // .... код пропущен
   private func verifyLoginData() {
       if login == "bar" && password == "foo" {
           viewModel.isUserLoggedIn = true
       } else {
           showIncorrectCredentialsWarning = true
       }
       password = ""
   }
    
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
                        Text("Login:")
                        Spacer()
                        TextField("Enter email", text: $login)
                            .frame(maxWidth: 150)
                    }
                    
                    HStack {
                        Text("Password:")
                        Spacer()
                        SecureField("Enter password", text: $password)
                            .frame(maxWidth: 150)
                    }
                    
//                    Button(action: verifyLoginData) {
//                        Text("Log in")
//                    }
                    
                    Button(action: {
                        self.verifyLoginData()
                    }, label: {
                        Text("Log in")
                    })
                    .padding()
                    .accentColor(.white)
                    .disabled(self.login.isEmpty || self.password.isEmpty)

                    
                    Spacer()
                }
                .autocapitalization(.none)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .frame(maxWidth: 250)
                .padding()
            }.onReceive( keyboardIsOnPublisher , perform: { isKeyboardShow in
                
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.shouldShowLogo = !isKeyboardShow
                }

            })
  
        }
        .onTapGesture {
            UIApplication.shared.endEditing()
        }
        .alert(isPresented: self.$showIncorrectCredentialsWarning, content: {
            
            Alert(title: Text("Incorrect Credentials"), message: Text("Incorrect login or password"), dismissButton: .cancel())
        })
    }
    
    
}



extension UIApplication {
    func endEditing() {
        self.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

