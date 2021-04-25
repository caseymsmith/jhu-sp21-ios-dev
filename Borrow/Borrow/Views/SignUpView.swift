//
//  SignUpView.swift
//  Borrow
//
//  Created by Casey on 4/23/21.
//

import SwiftUI

struct SignUpView: View {
    @State private var firstName = Array<String>.init(repeating: "", count: 1)
    @State private var lastName = Array<String>.init(repeating: "", count: 1)
    @State private var email = Array<String>.init(repeating: "", count: 1)
    @State private var password = Array<String>.init(repeating: "", count: 1)
    @State private var streetAddress = Array<String>.init(repeating: "", count: 1)
    @State private var optionalAddress = Array<String>.init(repeating: "", count: 1)
    @State private var city = Array<String>.init(repeating: "", count: 1)
    @State private var state = Array<String>.init(repeating: "", count: 1)
    @State private var zip = Array<String>.init(repeating: "", count: 1)
    @State var checked = false
    
    @State var showTermsAndConditionsView: Bool = false

    var body: some View {
        NavigationView {
            //Scrollable View helpful source: https://www.youtube.com/watch?v=YUGnQb7moHk
            ScrollView (.vertical, showsIndicators: false) {
                VStack {
                    Image("BorrowAppLogo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 350.0, height: 150.0)
                        .padding(.top, -100)
                    VStack (alignment: .leading){
                        Text("Sign Up")
                            .font(.title)
                            .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        
                        //Reference: https://stackoverflow.com/questions/56491881/move-textfield-up-when-the-keyboard-has-appeared-in-swiftui
                        TextField("First Name", text: $firstName[0])
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading, 10)
                            .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        TextField("Last Name", text: $lastName[0])
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        TextField("Email", text: $email[0])
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        TextField("Password", text: $password[0])
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        TextField("Street Address", text: $streetAddress[0])
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        TextField("Address Line 2 (Optional)", text: $optionalAddress[0])
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        TextField("City", text: $city[0])
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        HStack {
                            TextField("State", text: $state[0])
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            TextField("Zip", text: $zip[0])
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                        }.padding(.leading, 10)
                        .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    }.padding(.bottom, 10)
                    if showTermsAndConditionsView {
                        TermsConditionsView(checked: $checked)
                    } else {
                        Button(action: {
                            self.showTermsAndConditionsView = true
                            self.hidden()
                        }, label: {
                            Text("   Sign Up   ")
                                .fontWeight(.semibold)
                                .padding()
                                .foregroundColor(.white)
                                .background(Color.green)
                                .cornerRadius(20)
                        })
                    }
//                        NavigationLink(destination: TermsConditionsView(checked: $checked)) {
//                            Text("   Sign Up   ")
//                                .fontWeight(.semibold)
//                                .padding()
//                                .foregroundColor(.white)
//                                .background(Color.green)
//                                .cornerRadius(20)
//                        }
                    }
                }
            }
        }
    }

//switching views src: https://stackoverflow.com/questions/57311918/how-to-go-to-another-view-with-button-click

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
