//
//  CourseClass+CoreData.swift
//  Borrow
//
//  Created by Casey on 4/4/21.
//

import Foundation

extension CourseClass {
  
  func convertToManagedObject() -> CourseClassEntity {
    
    let courseClassEntity = CourseClassEntity(context: PersistenceController.shared.container.viewContext)
    courseClassEntity.id = self.id
    courseClassEntity.courseClassName = self.className.rawValue
    courseClassEntity.students = NSSet()
    for stud in students {
      courseClassEntity.addToStudents(stud.convertToManagedObject())
    }
    courseClassEntity.pastTeachers = NSSet()
    courseClassEntity.currentTeacher = nil
    
    return courseClassEntity
  }
  
  init(courseClassEntity: CourseClassEntity) {
    self.className = Courses(rawValue: courseClassEntity.courseClassName!)!
    self.id = courseClassEntity.id!
    self.students = []
    self.pastTeachers = []
    
    var tempStudents: [Student] = []
    for stud in courseClassEntity.students!.allObjects as! [StudentEntity] {
      
      let student = Student(studentEntity: stud)
      tempStudents.append(student)
    }
    self.students = tempStudents
    
    var tempPastTeacher: [Teacher] = []
    for teach in courseClassEntity.pastTeachers!.allObjects as! [TeacherEntity] {
      
      let teacher = Teacher(teacherEntity: teach)
      tempPastTeacher.append(teacher)
    }
    self.pastTeachers = tempPastTeacher
  }
}
