//
//  CourseClass.swift
//  Borrow
//
//  Created by Casey on 4/4/21.
//

import Foundation

struct CourseClass: Codable {
  
  public var id: UUID = UUID()
  let className: Courses
  var students: [Student] 
  var currentTeacher: Teacher?
  var pastTeachers: [Teacher]
  
}
