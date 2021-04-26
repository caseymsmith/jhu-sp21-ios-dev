//
//  AccountView.swift
//  Borrow
//
//  Created by Casey on 4/4/21.
//

import SwiftUI

//TODO: Update to pull data from user
struct AccountView: View {
    @State private var email = Array<String>.init(repeating: "", count: 1)
    @State private var oldPassword = Array<String>.init(repeating: "", count: 1)
    @State private var newPassword = Array<String>.init(repeating: "", count: 1)
    @State private var streetAddress = Array<String>.init(repeating: "1320 Muirlands Dr", count: 1)
    @State private var city = Array<String>.init(repeating: "La Jolla", count: 1)
    @State private var state = Array<String>.init(repeating: "CA", count: 1)
    @State private var zip = Array<String>.init(repeating: "92037", count: 1)
    
    var body: some View {
        
        VStack {
            Image("default_profile_pic")
            
            VStack{
                Text("Casey Smith")
                    .font(.title)
                Button(action: {
                    //TODO: ability to update profile picture
                }, label: {
                    Text("Update Profile Picture")
                })
                
                //Reference: https://stackoverflow.com/questions/56491881/move-textfield-up-when-the-keyboard-has-appeared-in-swiftui
                TextField("Email", text: $email[0])
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                TextField("Old Password", text: $oldPassword[0])
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                TextField("New Password", text: $newPassword[0])
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                TextField("Street Address", text: $streetAddress[0])
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
                Button(action: {
                    //TODO: Update any changed account info need to setup core data here
                }, label: {
                    Text("   Update   ")
                        .fontWeight(.semibold)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.green)
                        .cornerRadius(20)
                })
            }
            
        }
        
        
        
    }
    
    struct AccountView_Previews: PreviewProvider {
        static var previews: some View {
            AccountView()
        }
    }
    
}
