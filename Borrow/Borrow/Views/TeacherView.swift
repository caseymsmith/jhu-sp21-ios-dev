//
//  TeacherView.swift
//  Borrow
//
//  Created by Casey on 1/31/21.
//

import SwiftUI
import CloudKit

struct TeacherView: View {
  
  let teacher: Teacher
  let dateFormatter = DateFormatter()
  @State private var isReviewSheetShowing = false
  
  init(teacher: Teacher) {
    self.teacher = teacher
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
  }
  
  var body: some View {

    NavigationView {
      VStack {
        Image(teacher.imageName)
          .resizable()
          .aspectRatio(contentMode: .fit)
        Text(teacher.name).font(.title)
        Text(teacher.affiliation)
        Spacer().frame(height: 20)
        VStack {
          HStack {
            Text("Email:")
            Spacer()
            Text(teacher.email)
          }.padding(.bottom, 10)
          HStack {
            Text("JHED:")
            Spacer()
            Text(teacher.jhed)
          }.padding(.bottom, 10)
          HStack {
            Text("Start Date:")
            Spacer()
            Text("\(dateFormatter.string(from: teacher.startDate))")
          }.padding(.bottom, 10)
          HStack {
            Text("Highest Degree:")
            Spacer()
            Text(teacher.highestDegree.rawValue)
          }.padding(.bottom, 10)
          HStack {
            Text("Classes Taught:")
            Spacer()
            Text(teacher.classesTaught.map{$0.rawValue}.joined(separator: ",\n"))
              .font(.body)
          }.padding(.bottom, 10)
          HStack {
            Text("Actively Teaching:")
            Spacer()
            Text(teacher.activelyTeaching.map{$0.rawValue}.joined(separator: ",\n"))
          }.padding(.bottom, 10)
          HStack {
            Text("Current Rating:")
            Spacer()
            Text("\(teacher.currentRating, specifier: "%.2f")")
          }.padding(.bottom, 10)
        }.padding()
      }.navigationBarItems(trailing: Button("Submit a Review") {
        self.isReviewSheetShowing.toggle()
      }).sheet(isPresented: self.$isReviewSheetShowing, content: {
        ReviewView()
      })
    }
  }
}

struct ReviewView: View {
  
  @State var reviewText: String = ""
  @Environment(\.presentationMode) var presentation
  
  var body: some View {
    
    NavigationView {
      VStack {
        TextEditor(text: $reviewText).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
      }.navigationTitle("Leave a Review")
      .navigationBarItems(trailing: Button("Submit"){
        
        let id = UUID()
        let reviewID = CKRecord.ID(recordName: "\(id)")
        let review = CKRecord(recordType: "TeacherReview", recordID: reviewID)
        review["id"] = "\(id)"
        review["reviewText"] = reviewText
        
        let myContainer = CKContainer(identifier: "iCloud.edu.jhu.ep.steele.josh.EPGradebookS2021.rsteele3")
        //for the homework you will replace the identifier to match the one with your JHED

        let privateDatabase = myContainer.privateCloudDatabase

        privateDatabase.save(review) { record, error in if let error = error {
            print("We encountered an error saving to the cloud \(error)")
            return
          }
          print("Save successful! Go check it out in the CloudKit Dashboard!")
        }
        
        presentation.wrappedValue.dismiss()
      })
    }
  }
}

struct TeacherView_Previews: PreviewProvider {
  static var previews: some View {
    let josh = ClassAssignmentsModelTestData().teachers![0]
    return NavigationView {
      TeacherView(teacher: josh)
    }
  }
}
