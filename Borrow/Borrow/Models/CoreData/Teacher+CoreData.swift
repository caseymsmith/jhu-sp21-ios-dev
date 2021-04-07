//
//  Teacher+CoreData.swift
//  Borrow
//
//  Created by Casey on 4/4/21.
//

import Foundation

extension Teacher {
  
  func convertToManagedObject() -> TeacherEntity {
    
    let teacherEntity = TeacherEntity(context: PersistenceController.shared.container.viewContext)
    teacherEntity.name = self.name
    teacherEntity.email = self.email
    teacherEntity.jhed = self.jhed
    teacherEntity.imageName = self.imageName
    teacherEntity.startDate = self.startDate
    teacherEntity.highestDegree = self.highestDegree.rawValue
    teacherEntity.classesTaught = NSSet()
    teacherEntity.activelyTeaching = NSSet()
    teacherEntity.currentRating = self.currentRating
    teacherEntity.affiliation = self.affiliation
    return teacherEntity
  }
  
  init(teacherEntity: TeacherEntity) {
    self.name = teacherEntity.name!
    self.email = teacherEntity.email!
    self.jhed = teacherEntity.jhed!
    self.imageName = teacherEntity.imageName!
    self.startDate = teacherEntity.startDate!
    self.highestDegree = EdDegree.init(rawValue: teacherEntity.highestDegree!)!
    var tempClassesTaught: [Courses] = []
    for courseCl in teacherEntity.classesTaught!.allObjects as! [CourseClassEntity] {
      
      let schoolClass = CourseClass(courseClassEntity: courseCl)
      tempClassesTaught.append(schoolClass.className)
    }
    self.classesTaught = tempClassesTaught
    
    var tempActivelyTeaching: [Courses] = []
    for courseCl in teacherEntity.activelyTeaching!.allObjects as! [CourseClassEntity] {
      
      let schoolClass = CourseClass(courseClassEntity: courseCl)
      tempActivelyTeaching.append(schoolClass.className)
    }
    self.activelyTeaching = tempActivelyTeaching
    
    self.currentRating = teacherEntity.currentRating
    self.affiliation = teacherEntity.affiliation!
  }
}
