//
//  HistoryView.swift
//  Borrow
//
//  Created by Casey on 1/31/21.
//

import SwiftUI


struct HistoryView: View {

    //resize navigation bar title source: https://www.ioscreator.com/tutorials/swiftui-customize-navigation-bar-tutorial
    init() {
            UINavigationBar.appearance().largeTitleTextAttributes = [
                .foregroundColor: UIColor.black,
                .font : UIFont(name:"Helvetica", size: 30)!]
        }
    
    var body: some View {
        NavigationView {
            //ideally it would be nice to have this data pulled rather than hard coded and have more styling. This is a nice source with direction this page would be amazing to go in: https://developer.apple.com/tutorials/swiftui/building-lists-and-navigation
            List{
              NavigationLink(destination: NotificationView(), label: { Text("Completed borrow from Sam") })
              NavigationLink(destination: CompletedBorrowView(), label: { Text("Andy wants to borrow your 'Road Bike'") })
              
            }.navigationTitle("History and Notifications")
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
