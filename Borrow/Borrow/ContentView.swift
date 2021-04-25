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
  @State var model: AssignmentGraderModel
  
  var body: some View {
    CoreDataView(selection: selection, model: $model)
  }
}

//
//struct JSONDataView: View {
//  
//  @Binding var selection: Int
//  @Binding var model: AssignmentGraderModel
//  
//  var body: some View {
//    
//    TabView(selection: $selection) {
//      
//      CourseClassView(courseClass: model.schoolClasses[0])
//        .tabItem{ Text("Class") }
//        .tag(1)
//      AssignmentsTableView(assignments: model.assignments)
//        .tabItem{ Text("Assignments") }
//        .tag(2)
//      StudentsView(student: model.students[0])
//        .tabItem{ Text("Student") }
//        .tag(3)
//      TeacherView(teacher: model.teachers[0])
//        .tabItem{ Text("Teacher") }
//        .tag(4)
//    }
//    
//  }
//  
//}

struct CoreDataView: View {
  
  @State var selection = 1
  @Binding var model: AssignmentGraderModel
  @Environment(\.managedObjectContext) var context
  
  @FetchRequest(
    entity: AssignmentEntity.entity(),
    sortDescriptors: [
      NSSortDescriptor(keyPath: \AssignmentEntity.name, ascending: true),
  ]) var assignments: FetchedResults<AssignmentEntity>

  @FetchRequest(
    entity: CourseClassEntity.entity(),
    sortDescriptors: [
      NSSortDescriptor(keyPath: \CourseClassEntity.courseClassName, ascending: true),
  ]) var courseClasses: FetchedResults<CourseClassEntity>

  @FetchRequest(
    entity: TeacherEntity.entity(),
    sortDescriptors: [
      NSSortDescriptor(keyPath: \TeacherEntity.name, ascending: true),
  ]) var teachers: FetchedResults<TeacherEntity>
  
  @FetchRequest(entity: StudentEntity.entity(),
                sortDescriptors: [NSSortDescriptor(keyPath: \StudentEntity.name, ascending: true),
  ]) var students: FetchedResults<StudentEntity>
  
  init(selection: Int, model: Binding<AssignmentGraderModel>) {
    _model = model

    self.selection = selection
    let options:UNAuthorizationOptions = [.alert, .sound]

    UNUserNotificationCenter.current().requestAuthorization(options: options, completionHandler: {
       success, error in
        guard success == true else { print("Access not granted or error"); return }
        print("notification access granted")
    })
  }
  
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

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(model: ClassAssignmentsModel.designModel)
  }
}
