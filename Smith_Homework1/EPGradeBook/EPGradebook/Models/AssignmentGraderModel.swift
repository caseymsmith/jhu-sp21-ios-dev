//
//  AssignmentGraderModel.swift
//  EPGradebook
//
//  Created by Teacher on 1/21/21.
//

import Foundation

protocol AssignmentGraderModel {
  var schoolClasses: [CourseClass] { get }
  var assignments: [Assignment] { get }
  var teachers: [Teacher] { get }
  var students: [Student] { get }
}
