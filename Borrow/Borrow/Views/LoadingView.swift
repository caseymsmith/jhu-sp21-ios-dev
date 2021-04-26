//
//  LoadingView.swift
//  Borrow
//
//  Created by Casey on 2/14/21.
//

import SwiftUI

struct LoadingView: View {

  @Binding var networkDataLoaded: Bool
  
  var body: some View {
    //Found this activity indicator that comes with xcode/apple developers! Fun. Source: https://stackoverflow.com/questions/56496638/activity-indicator-in-swiftui
    ProgressView()
  }
}
