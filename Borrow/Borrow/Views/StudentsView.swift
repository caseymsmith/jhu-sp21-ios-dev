//
//  StudentsView.swift
//  Borrow
//
//  Created by Casey on 1/31/21.
//

import SwiftUI
import MessageUI

struct StudentsView: View {
  
  @Environment(\.presentationMode) var presentation
  var student: Student
  @State var result: Result<MFMailComposeResult, Error>? = nil
  @State private var isMailShowing = false
  @State private var isMapShowing = false
  @State var image: Image?
  @State var uiImage: UIImage!

  var body: some View {

  //HW6: Use a ZStack to add a button on top of the image, in the upper right hand corner (ZStack has an initializer that may help with this).  Upon pressing the button, apply a filter of your choice to the image.  
    
    VStack {
      ZStack(alignment: .topTrailing) {
        image?.resizable().aspectRatio(contentMode: .fit)
        Button("Apply Filter"){ self.applyFilter(name: self.student.imageName)}.background(Color.white).padding([.top, .trailing])
      }.onAppear{
        guard let uiImage = UIImage(named: self.student.imageName) else { return }
        self.uiImage = uiImage
        self.image = Image(self.student.imageName)
      }
      Text(student.name).font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
      Spacer().frame(height: 20)
      Form {
        HStack {
          Text("Address:")
          Spacer()
          Text(student.address)
        }.padding(.bottom, 10)
         .onTapGesture {
          self.isMapShowing.toggle()
        }
        .sheet(isPresented: $isMapShowing, content:
        {
          NavigationView {
          MapView(students: [self.student], center: true)
            .navigationBarTitle("Student Location")
            .navigationBarItems(trailing: Button("Done")
            {
              self.isMapShowing.toggle()
            })
          }
        })
        HStack {
          Text("Email:")
          Spacer()
          Text(student.email)
        }.padding(.bottom, 10)
        .onTapGesture {
          self.isMailShowing.toggle()
        }
        .sheet(isPresented: self.$isMailShowing, content:
          {
            MailView(isShowing: self.$isMailShowing, result: self.$result)
        })
        HStack {
          Text("JHED:")
          Spacer()
          Text(student.jhed)
        }
        HStack {
          Text("Current Grade Average:")
          Spacer()
          Text("\(student.averageGrade, specifier: "%.2f")")
        }
      }
    }
  }
  
  func applyFilter(name: String) {
    
    let ciImage = CIImage(image: uiImage)
    let ciFilter = CompoundEye()
    let context = CIContext(options: nil)

    ciFilter.inputImage = ciImage
    
    guard let outputImage = ciFilter.outputImage else { return }
        
    if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
        // convert that to a UIImage
        uiImage = UIImage(cgImage: cgimg)
        // and convert that to a SwiftUI image
        image = Image(uiImage: uiImage!)
    }
  }
}


struct StudentRowView: View {
  
  var student: Student
  
  var body: some View {
    HStack {
      Image(student.imageName).resizable().aspectRatio(contentMode: .fit).frame(width: 100)
      Text(student.name)
    }
  }
  
}

struct StudentTable: View {
  
  var students: [Student]
  
  var body: some View {
    List(students, id: \.jhed) { student in
      NavigationLink(destination: StudentsView(student: student)) {
        StudentRowView(student: student)
      }
    }
  }
  
}

struct StudentsView_Previews: PreviewProvider {
  static var previews: some View {
    let students = ClassAssignmentsModelTestData().students
    return Group {
      StudentsView(student: students![0])
      StudentsView(student: students![0]).previewDevice("iPhone 8")
      StudentsView(student: students![0]).previewDevice("iPhone 11")
      StudentRowView(student: students![0]).previewLayout(.fixed(width: 300, height: 100))
      StudentTable(students: students!)
    }
  }
}
