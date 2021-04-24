//
//  LoadingView.swift
//  Borrow
//
//  Created by Casey on 2/14/21.
//

import SwiftUI

struct LoadingView: View {

  @Binding private var networkDataLoaded: Bool
  
  init(dataModel: ClassAssignmentsCoreDataModel, networkDataLoaded: Binding<Bool>) {
    _networkDataLoaded = networkDataLoaded
    let dataModel = ClassAssignmentsCoreDataModel()
    dataModel.loadAllDatabaseData(isLoaded: networkDataLoaded)
  }
  
  var body: some View {
    //Found this activity indicator that comes with xcode/apple developers! Fun. Source: https://stackoverflow.com/questions/56496638/activity-indicator-in-swiftui
    ProgressView()
  }
}

struct LoadingView_Previews: PreviewProvider {
  static var previews: some View {
    LoadingView(dataModel: ClassAssignmentsCoreDataModel(), networkDataLoaded: .constant(false))
  }
}
