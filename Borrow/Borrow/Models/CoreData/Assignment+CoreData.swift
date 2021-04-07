//
//  Assignment+CoreData.swift
//  Borrow
//
//  Created by Casey on 4/4/21.
//

import Foundation

extension Assignment {
  
  func convertToManagedObject() -> AssignmentEntity {
    
    let assignmentEntity = AssignmentEntity(context: PersistenceController.shared.container.viewContext)
    assignmentEntity.id = self.id
    assignmentEntity.name = self.name
    assignmentEntity.releaseDate = self.releaseDate
    assignmentEntity.dueDate = self.dueDate
    assignmentEntity.assignmentDescription = self.description
    assignmentEntity.maxGrade = self.maxGrade
    assignmentEntity.assignmentType = self.assignmentType.rawValue
    assignmentEntity.averageRating = self.averageRating
    
    return assignmentEntity
  }
  
  init(assignmentEntity: AssignmentEntity) {
    self.id = assignmentEntity.id!
    self.name = assignmentEntity.name!
    self.releaseDate = assignmentEntity.releaseDate!
    self.dueDate = assignmentEntity.dueDate!
    self.description = assignmentEntity.assignmentDescription!
    self.maxGrade = assignmentEntity.maxGrade
    self.assignmentType = AssignmentType(rawValue: assignmentEntity.assignmentType!)!
    self.averageRating = assignmentEntity.averageRating
    
  }
}

extension AssignmentGrade {
  
  func convertToManagedObject() -> AssignmentGradeEntity {
    
    let assignmentGradeEntity = AssignmentGradeEntity(context: PersistenceController.shared.container.viewContext)
    assignmentGradeEntity.grade = self.grade
    assignmentGradeEntity.graderComments = self.graderComments
    assignmentGradeEntity.assignment = self.assignment.convertToManagedObject()
    return assignmentGradeEntity
  }
  
  init(assignmentGrade: AssignmentGradeEntity) {
    
    self.assignment = Assignment(assignmentEntity: assignmentGrade.assignment!)
    self.grade = assignmentGrade.grade
    self.graderComments = assignmentGrade.graderComments!
  }
}
