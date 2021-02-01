//
//  ClassAssignmentsModel.swift
//  EPGradebook
//
//  Created by Teacher on 1/21/21.
//

import Foundation

//Programming Assignment 1: Uncomment the lines below, and complete the ClassAssignmentsModelTestData struct below to load the data
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

    let studentFileUrl = Bundle.main.url(forResource: "student", withExtension: "json")
    let classesFileUrl = Bundle.main.url(forResource: "classes", withExtension: "json")
    let assignmentsFileUrl = Bundle.main.url(forResource: "assignments", withExtension: "json")
    let teacherFileUrl = Bundle.main.url(forResource: "teacher", withExtension: "json")
    
    init(){
      //gathers the data from each of the file url's into json data properties
      let decoder = JSONDecoder()
      let studentJsonString = try! String(contentsOf: self.studentFileUrl!, encoding: String.Encoding.utf8)
      let studentJsonData = Data(studentJsonString.utf8)
      let classesJsonString = try! String(contentsOf: self.classesFileUrl!, encoding: String.Encoding.utf8)
      let classesJsonData = Data(classesJsonString.utf8)
      let assignmentsJsonString = try! String(contentsOf: self.assignmentsFileUrl!, encoding: String.Encoding.utf8)
      let assignmentsJsonData = Data(assignmentsJsonString.utf8)
      let teacherJsonString = try! String(contentsOf: self.teacherFileUrl!, encoding: String.Encoding.utf8)
      let teacherJsonData = Data(teacherJsonString.utf8)

      do {
            //adds the student, class, assignment, and teacher read in from the json files to the class assignments model then appends the new array value to the model array of values
            let student = try decoder.decode([Student].self, from: studentJsonData)
            self.students?.append(contentsOf: student)
            let aClass = try decoder.decode([CourseClass].self, from: classesJsonData)
            self.schoolClasses?.append(contentsOf: aClass)
            let assignment = try decoder.decode([Assignment].self, from: assignmentsJsonData)
            self.assignments?.append(contentsOf: assignment)
            let teacher = try decoder.decode([Teacher].self, from: teacherJsonData)
            self.teachers?.append(contentsOf: teacher)

       } catch {
            //error handling for when reading from JSON files
            print(error.localizedDescription)
      }
    }
}
  
let testData = ClassAssignmentsModelTestData()
let testModel = ClassAssignmentsModel(schoolClasses: testData.schoolClasses!, assignments: testData.assignments!, teachers: testData.teachers!, students: testData.students!)
