//
//  AssignmentView.swift
//  Borrow
//
//  Created by Casey on 1/31/21.
//

import SwiftUI
import AVKit

struct SlideToUnlockView: View {
  
  @GestureState var buttonPosition = CGPoint(x: 55, y: 25)
  @GestureState var buttonX:CGFloat = 0.0
  @Binding var isDragFinished: Bool
  
  var body: some View {
    
    HStack {
      Button(action: {
      }) {
        HStack(spacing: 15) {
          Image(systemName:"icloud.and.arrow.up")
          Text("Upload")
        }.padding(5)
        .padding(.top, 5)
        .padding(.bottom, 5)
      }
      
      .background(Color(red: 0.8, green: 0.8, blue: 0.8))
      .cornerRadius(10)
      .position(buttonPosition)
      .frame(height: 50)
      .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 5)
      .highPriorityGesture(
        DragGesture()
          .updating($buttonPosition) { value, state, transaction in
            if (value.translation.height <= 5)
            {
              state = CGPoint(x: value.location.x, y: 25)
            }
          }
          .onEnded{value in
            isDragFinished = true
            print("value is \(value)")
            //                self.animateAndUpload()
          }
      )
      
      Spacer()
    }
    .overlay(
      Capsule(style: .continuous)
        .stroke(lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
        .padding(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/, 2)
    )
  }
}

struct SlideToUnlockView_Previews: PreviewProvider {
  static var previews: some View {
    
    VStack {
      SlideToUnlockView(isDragFinished: .constant(false))
    }
    .previewLayout(.sizeThatFits)
  }
}

struct AnimatedStarView: View {
  
  @Binding var starOpacity: Double
  @Binding var starScale: CGFloat
  @Binding var rotationAmount: Double
  @Binding var starColor: Color
  @Binding var isAnimationDone: Bool
  
  var body: some View {
    Image(systemName: "star")
      .opacity(starOpacity)
      .scaleEffect(starScale)
      .rotationEffect(Angle(radians: rotationAmount * .pi))
      .foregroundColor(starColor)
      .animation(.easeInOut)
//      .animation(.interpolatingSpring(stiffness: 0.1, damping: 0.5))
  }
}

struct AnimatedStarView_Previews: PreviewProvider {
  
  static var previews: some View {
    
    return VStack {
      Spacer()
      AnimatedStarView(starOpacity: .constant(1.0),
                       starScale: .constant(1.0),
                       rotationAmount: .constant(0.0),
                       starColor: .constant(Color.black),
                       isAnimationDone: .constant(false))
        .padding(.horizontal, 100)
      Spacer()
    }
    .previewLayout(.sizeThatFits)
  }
}

struct SlideToUploadView: View {
  
  @State var starOpacity: Double = 0.0
  @State var starScale: CGFloat = 1.0
  @State var rotationAmount: Double = 0.0
  @State var isAnimationDone: Bool = false
  @State var isDragDone: Bool = false
  @State var animationShowing = false
  @State var starColor = Color.black
  
  var notificationCenter:UNUserNotificationCenter!
  var notificationDelegate: NotificationDelegate!
  var completionBlock: (() -> ())!
  
  
  init() {
    self.notificationCenter = UNUserNotificationCenter.current()
    self.notificationDelegate = NotificationDelegate()
  }
  
  var body: some View {
    
    VStack {
      Spacer()
      if isDragDone == true {
        AnimatedStarView(starOpacity: $starOpacity, starScale: $starScale, rotationAmount: $rotationAmount, starColor: $starColor, isAnimationDone: $isAnimationDone)
      }
      Spacer()
      SlideToUnlockView(isDragFinished: $isDragDone)
    }
    .onChange(of: isDragDone, perform: { value in
      starOpacity = 1.0
      starScale = 3.0
      rotationAmount = 8.0
      isAnimationDone = true
      starColor = .yellow
    })
    .onChange(of: isAnimationDone, perform: { value in
      self.setupAndFireNotification()
      DispatchQueue.main.asyncAfter(deadline: .now() + 4, execute: {
        starOpacity = 0.0
        starScale = 1.0
        rotationAmount = 0.0
        starColor = .black
      })
    })
    
  }
  
  func setupAndFireNotification() {
    
    let content = UNMutableNotificationContent()
    content.title = "Assignment Submitted!"
    content.body = "Congrats! You've submitted your assignment!"
    content.sound = UNNotificationSound.default
    
    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 3, repeats: false)
    
    let notification = UNNotificationRequest(identifier: "AssignmentUploadNotification", content: content, trigger: trigger)
    
    notificationCenter.add(notification)
    {
      error in
      if let error = error
      {
        print("Error firing notification: \(error.localizedDescription)")
      }
    }
  }
  
}

struct SlideToUploadView_Previews: PreviewProvider {
  static var previews: some View {
    
    SlideToUploadView()
      .previewLayout(.sizeThatFits)
  }
}


struct AssignmentView: View {
  
  let assignment: Assignment
  let formatter = DateFormatter()
  
  init(assignment: Assignment) {
    self.assignment = assignment
    formatter.dateStyle = .medium
    formatter.timeStyle = .medium
  }
  
  var body: some View {
    VStack {
      Text("Type: \(assignment.assignmentType.rawValue)")
      Text("Due \(formatter.string(from: assignment.dueDate))")
      Text("Max Grade: \(assignment.maxGrade, specifier: "%.2f")")
      Spacer().frame(height: 20)
      VideoPlayer(player: AVPlayer(url: URL(string: "http://159.203.191.136/8-Week8-Introduction.mp4")!))
      Spacer().frame(height: 10)
      Text("Description: \(assignment.description)")
      //Button will go here later for upload of the assignment
      Spacer()
      SlideToUploadView()
    }.navigationBarTitle(assignment.name)
  }
}

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
  
  override init() {
    super.init()
    UNUserNotificationCenter.current().delegate = self
  }
  
  func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
    
    completionHandler([.banner,.sound])
    
  }
}


struct AssignmentView_Previews: PreviewProvider {
  static var previews: some View {
    TabView {
      NavigationView {
        AssignmentView(assignment: ClassAssignmentsModelTestData().assignments![0])
      }
    }
  }
}

struct AssignmentsTableView: View {
  
  var assignments: [Assignment]
  
  var body: some View {
    
    NavigationView {
      
      List(assignments, id: \.id) { assignment in
        NavigationLink(destination: AssignmentView(assignment: assignment), label: {
          Text("\(assignment.name)")
        })
      }.navigationBarTitle("Assignments")
    }
  }
}

struct AssignmentsTableView_Previews: PreviewProvider {
  static var previews: some View {
    AssignmentsTableView(assignments: ClassAssignmentsModel.designModel.assignments)
  }
}
