//
//  AssignmentGrade.swift
//  EPGradebook
//
//  Created by Teacher on 1/21/21.
//

import Foundation

struct AssignmentGrade: Codable {
  
  let assignment: Assignment
  let grade: Double
  let graderComments: String
  
}
