//
//  LoginView.swift
//  swiftui-1347
//
//  Created by Artur Igberdin on 26.10.2021.
//

import SwiftUI
import Combine

struct LoginView: View {
    
    @Binding var shouldShowCitiesView: Bool
    
    @State var login: String = ""
    @State var password: String = ""
    @State private var shouldShowLogo: Bool = true
    @State private var showIncorrentCredentialsWarning = false
    
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
        .alert(isPresented: self.$showIncorrentCredentialsWarning, content: {
            
            Alert(title: Text("Incorrect Credentials"), message: Text("Incorrect login or password"), dismissButton: .cancel())
        })
    }
    
    private func verifyLoginData() {
        if login == "bar" && password == "foo" {
            // authorizing user
            shouldShowCitiesView = true
        } else {
            showIncorrentCredentialsWarning = true
        }
        // сбрасываем пароль, после проверки для лучшего UX
        password = ""
    }
}



extension UIApplication {
    func endEditing() {
        self.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(shouldShowCitiesView: .constant(false))
    }
}
