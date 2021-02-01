//
//  ContentView.swift
//  EPGradebook
//
//  Created by Teacher on 1/20/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
  @Environment(\.managedObjectContext) private var viewContext
  
  var body: some View {
    Text("Hello world")
  }
  

}
struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
