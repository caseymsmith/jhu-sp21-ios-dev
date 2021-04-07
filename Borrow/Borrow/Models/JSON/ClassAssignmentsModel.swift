//
//  ClassAssignmentsModel.swift
//  Borrow
//
//  Created by Casey on 1/21/21.
//

import Foundation

struct ClassAssignmentsModel: AssignmentGraderModel {
  
  var schoolClasses: [CourseClass]
  var assignments: [Assignment]
  var teachers: [Teacher]
  var students: [Student]
  
  static var designModel: ClassAssignmentsModel = testModel
}

struct ClassAssignmentsModelTestData {
  
  var schoolClasses: [CourseClass]?
  var assignments: [Assignment]?
  var teachers: [Teacher]?
  var students: [Student]?
  
  init() {
    do {
      if let bundlePath = Bundle.main.path(forResource: "teacher", ofType: "json"),
        let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
        let decoder = JSONDecoder()
        teachers = try decoder.decode([Teacher].self, from: jsonData)
      }
      
      if let bundlePath = Bundle.main.path(forResource: "student", ofType: "json"),
        let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
          let decoder = JSONDecoder()
          students = try decoder.decode([Student].self, from: jsonData)
      }

      if let bundlePath = Bundle.main.path(forResource: "assignments", ofType: "json"),
        let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
        let decoder = JSONDecoder()
        assignments = try decoder.decode([Assignment].self, from: jsonData)
      }

      if let bundlePath = Bundle.main.path(forResource: "classes", ofType: "json"),
        let jsonData = try String(contentsOfFile: bundlePath).data(using: .utf8) {
        let decoder = JSONDecoder()
        schoolClasses = try decoder.decode([CourseClass].self, from: jsonData)
      }
      
    } catch {
      print("An error occurred during decoding: \(error)")
    }
    
  }
}
  
let testData = ClassAssignmentsModelTestData()
let testModel = ClassAssignmentsModel(schoolClasses: testData.schoolClasses!, assignments: testData.assignments!, teachers: testData.teachers!, students: testData.students!)

