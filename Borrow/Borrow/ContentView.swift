//
//  ContentView.swift
//  Borrow
//
//  Created by Casey on 1/20/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
  
  @State private var selection = 1
  
    //TODO: Need to add core data things here.
    
  var body: some View {
      TabView(selection: $selection) {
        MapView()
          .tabItem { Image(systemName: "house.fill") ; Text("Home") }
          .tag(1)
        MessagesView(contentMessage: "Hello", isCurrentUser: true).tabItem { Image(systemName: "message.circle") ; Text("Messages") }.tag(2)
        HistoryView().tabItem { Image(systemName: "clock") ; Text("History") }.tag(3)
        AccountView().tabItem { Image(systemName: "person.circle") ; Text("My Account") }
          .tag(4)
      }
    }
}

