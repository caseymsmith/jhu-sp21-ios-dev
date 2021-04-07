//
//  Student+CoreData.swift
//  Borrow
//
//  Created by Casey on 4/4/21.
//

import Foundation

extension Student {
  
  func convertToManagedObject() -> StudentEntity {
    
    let studentEntity = StudentEntity(context: PersistenceController.shared.container.viewContext)
    studentEntity.name = self.name
    studentEntity.address = self.address
    studentEntity.program = self.program.rawValue
    studentEntity.email = self.email
    studentEntity.jhed = self.jhed
    studentEntity.imageName = self.imageName

    studentEntity.assignmentGrades = NSSet()
    //loop over assignment grades, and add separately
    for assignmentGrade in self.assignmentGrades {
      let assignmentGradeEntity = AssignmentGradeEntity(context: PersistenceController.shared.container.viewContext)
      assignmentGradeEntity.grade = assignmentGrade.grade
      assignmentGradeEntity.graderComments = assignmentGrade.graderComments
      let assignment = ClassAssignmentsCoreDataModel.getAssignmentWith(uuid: assignmentGrade.assignment.id)
      assignmentGradeEntity.assignment = assignment
      studentEntity.addToAssignmentGrades(assignmentGradeEntity)
    }
    return studentEntity
    
  }
  
  init(studentEntity: StudentEntity) {
    self.name = studentEntity.name!
    self.address = studentEntity.address!
    self.program = Program(rawValue: studentEntity.program!)!
    self.email = studentEntity.email!
    self.jhed = studentEntity.jhed!
    self.imageName = studentEntity.imageName!

    var tempAssignments: [AssignmentGrade] = []
    for gradeEn in studentEntity.assignmentGrades!.allObjects as! [AssignmentGradeEntity] {
      
      let assignmentGrade = AssignmentGrade(assignmentGrade: gradeEn)
      tempAssignments.append(assignmentGrade)
    }
    self.assignmentGrades = tempAssignments
  }
}
