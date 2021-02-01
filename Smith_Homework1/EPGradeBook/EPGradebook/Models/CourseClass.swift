//
//  CourseClass.swift
//  EPGradebook
//
//  Created by Teacher on 1/21/21.
//

import Foundation

struct CourseClass: Codable {
  
  public var id: UUID = UUID()
  let className: Courses
  var students: [Student]
  var currentTeacher: Teacher?
  var pastTeachers: [Teacher]
  
}
