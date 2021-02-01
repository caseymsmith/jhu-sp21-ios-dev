//
//  Student.swift
//  EPGradebook
//
//  Created by Teacher on 1/21/21.
//

import Foundation

//Property for the program to which the student belongs to
// but NOT as a String in the Student struct
enum ProgramType: String, Codable {
  case computerScience = "Computer Science"
  case engineering = "Engineering"
  case engineeringManagement = "Engineering Management"
  case electricalCompEngineering = "Electrical and Computer Engineering"
}

struct Student: Codable {
  
  let name: String
  let address: String
  let email: String
  let jhed: String
  let imageName: String
  let program: ProgramType
  let assignmentGrades: [AssignmentGrade]
  var averageGrade: Double?
}

extension Student {
    mutating func calculateAssignmentAverage() {
        //0.0 is initial value of grade average 0.
        self.averageGrade = self.assignmentGrades.reduce(0.0) {
            //$0 = 0.0 at first, then $1 is 0th index
            return $0 + $1.grade/Double(assignmentGrades.count)
        }
    }
}
