//
//  LoginScreen.swift
//  Borrow
//
//  Created by Casey on 1/31/21.
//

import SwiftUI
import FBSDKLoginKit

struct LoginScreen: View {
        
    @State private var username: String = UserDefaults.standard.string(forKey: "username") ?? ""
    @State private var password: String = ""
    @EnvironmentObject var userAuth: UserAuth
    @State private var networkDataLoaded: Bool = false
    
    var body: some View {
        if !userAuth.isLoggedIn {
            
            return AnyView(VStack {
                
                Spacer(minLength: 100)
                Image("BorrowAppLogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Spacer(minLength: 10)
                VStack(alignment: .center) {
                    HStack {
                        Spacer(minLength: 50)
                        TextField("Username", text: $username)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Spacer(minLength: 50)
                    }
                    HStack {
                        Spacer(minLength: 50)
                        SecureField("Password", text: $password)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        Spacer(minLength: 50)
                    }
                    Button(action: {
                        self.saveUserName(userName: self.username)
                        self.userAuth.login()
                    }, label: { Text("Login") })
                    Button(action: {
                        //TODO: Add sign up screen
                    }, label: { Text("Sign Up") })
                    Spacer(minLength: 50)

                    
                    //TODO: Update login with facebook button using SDK for more iconic button
                    Button(action: {
                        
                    }, label: {
                        Text("Login with Facebook")
                            .foregroundColor(.white)
                            .padding(.vertical,10)
                            .padding(.horizontal,35)
                            .background(Color.blue)
                            .clipShape(Capsule())
                    })
                    
                }
                Spacer(minLength: 50)
            })
        }
        else {
            let dataModel = ClassAssignmentsCoreDataModel()
            if networkDataLoaded == false {
                return AnyView(LoadingView(dataModel: dataModel, networkDataLoaded: $networkDataLoaded))
            }
            else {
                return AnyView(ContentView(model: dataModel))
            }
        }
    }
    
    class ViewController: UIViewController {

        override func viewDidLoad() {
            super.viewDidLoad()
        
            let loginButton = FBLoginButton()
            loginButton.center = view.center
            view.addSubview(loginButton)
        }
    }

}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen().environmentObject(UserAuth())
    }
}
