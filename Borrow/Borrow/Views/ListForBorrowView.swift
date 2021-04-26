//
//  ListForBorrowView.swift
//  Borrow
//
//  Created by Casey on 4/23/21.
//
import SwiftUI

struct ListForBorrowView: View {
    @State private var itemTitle = Array<String>.init(repeating: "", count: 1)
    @State private var description = Array<String>.init(repeating: "", count: 1)
    @State private var cost = Array<String>.init(repeating: "", count: 1)
    @State private var timeUnit = Array<String>.init(repeating: "", count: 1)
    @State private var replacement = Array<String>.init(repeating: "", count: 1)
    
    var body: some View {
        
        VStack {
            Button(action: {
                ///TODO: Tap to uplaod photo https://www.youtube.com/watch?v=hbze1aL4-II
                
            }, label: {
                Text("Tap Here to Upload a Photo")
            })
            
            //Reference: https://stackoverflow.com/questions/56491881/move-textfield-up-when-the-keyboard-has-appeared-in-swiftui
            TextField("Item Title", text: $itemTitle[0])
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            TextField("Description", text: $description[0])
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            TextField("Cost", text: $cost[0])
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            TextField("Hour", text: $timeUnit[0])
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            TextField("Item Replacement Cost", text: $replacement[0])
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.leading, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                .padding(.trailing, /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            Text("Note: This will be available to Borrower's")
                .foregroundColor(Color.gray)
            Button(action: {
                //TODO: Update any changed account info need to setup core data here
            }, label: {
                Text("   Post   ")
                    .fontWeight(.semibold)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.green)
                    .cornerRadius(20)
            })
        }
        
    }
}

struct ListForBorrowView_Previews: PreviewProvider {
    static var previews: some View {
        ListForBorrowView()
    }
}
