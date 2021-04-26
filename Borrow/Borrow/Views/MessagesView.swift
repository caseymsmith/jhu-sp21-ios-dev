//
//  MessagesView.swift
//  Borrow
//
//  Created by Casey on 1/31/21.
//

import SwiftUI
import AVKit
import MessageUI

struct Message {
    var content: String
    var user: User
}
struct User {
    var name: String
    var avatar: String
    var isCurrentUser: Bool = false
}

struct ContentMessageView: View {
    var contentMessage: String
    var isCurrentUser: Bool
    
    var body: some View {
        Text(contentMessage)
            .padding(10)
            .foregroundColor(isCurrentUser ? Color.white : Color.black)
            .background(isCurrentUser ? Color.blue : Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)))
            .cornerRadius(10)
    }
}

//Source: https://www.iosapptemplates.com/blog/swiftui/swiftui-chat
struct MessagesView: View {
    var contentMessage: String
    var isCurrentUser: Bool
    
    var body: some View {
        //TODO: Add navigation view and allow for list of messages
        
        HStack(alignment: .bottom, spacing: 15) {
            //TODO: setup images to get pulled from user accounts
            Image("My-avatar")
                .resizable()
                .frame(width: 40, height: 40, alignment: .center)
                .cornerRadius(20)
            ContentMessageView(contentMessage: "This is an example sent message",
                               isCurrentUser: false)
        }
    }
}
