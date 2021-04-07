//
//  Teacher.swift
//  Borrow
//
//  Created by Casey on 4/4/21.
//

import Foundation

struct Teacher: Codable {
  
  let name: String
  let email: String
  let jhed: String
  let imageName: String
  let startDate: Date
  let highestDegree: EdDegree
  var classesTaught: [Courses]
  var activelyTeaching: [Courses]
  var currentRating: Double
  let affiliation: String
  
}
