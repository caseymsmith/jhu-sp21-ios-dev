//
//  Assignment.swift
//  Borrow
//
//  Created by Casey on 4/4/21.//

import Foundation

struct Assignment: Codable {
  
  public var id: UUID = UUID()
  public let name: String
  let releaseDate: Date
  let dueDate: Date
  let description: String
  let maxGrade: Double
  let assignmentType: AssignmentType
  var averageRating: Double
  
}
