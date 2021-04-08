//
//  Student.swift
//  EPGradebook
//
//  Created by Casey on 1/21/21.
//

import Foundation

struct Student: Codable {
  
  let name: String
  let address: String
  let program: Program
  let email: String
  let jhed: String
  let imageName: String
  let assignmentGrades: [AssignmentGrade]
  var averageGrade: Double {
    
    guard assignmentGrades.count > 0 else { return 0 }
    return assignmentGrades.reduce(0) { $0
      + $1.grade }/Double(assignmentGrades.count)
  }
}
