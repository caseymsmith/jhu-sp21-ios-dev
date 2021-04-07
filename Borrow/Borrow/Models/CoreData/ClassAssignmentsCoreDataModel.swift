//
//  ClassAssignmentsCoreDataModel.swift
//  Borrow
//
//  Created by Casey on 4/4/21.
//

import Foundation
import SwiftUI
import CoreData

struct ClassAssignmentsCoreDataModel: AssignmentGraderModel {
  var schoolClasses: [CourseClass] { return [] }
  var assignments: [Assignment] { return [] }
  var students: [Student] { return [] }
  var teachers: [Teacher] { return [] }

  static var context = PersistenceController.shared.container.viewContext
  let classAssignmentTestData = ClassAssignmentsModelTestData()
  
  //Populating/Clearing methods
  func emptyDB() {
    
    let studentFetchRequest: NSFetchRequest<NSFetchRequestResult> = StudentEntity.fetchRequest()
    let studentDeleteRequest = NSBatchDeleteRequest(fetchRequest: studentFetchRequest)
    
    let teacherFetchRequest: NSFetchRequest<NSFetchRequestResult> = TeacherEntity.fetchRequest()
    let teacherDeleteRequest = NSBatchDeleteRequest(fetchRequest: teacherFetchRequest)
    
    let classesFetchRequest: NSFetchRequest<NSFetchRequestResult> = CourseClassEntity.fetchRequest()
    let classesDeleteRequest = NSBatchDeleteRequest(fetchRequest: classesFetchRequest)
    
    let assignmentsFetchRequest: NSFetchRequest<NSFetchRequestResult> = AssignmentEntity.fetchRequest()
    let assignmentsDeleteRequest = NSBatchDeleteRequest(fetchRequest: assignmentsFetchRequest)

    do {
      try ClassAssignmentsCoreDataModel.context.execute(studentDeleteRequest)
      try ClassAssignmentsCoreDataModel.context.execute(teacherDeleteRequest)
      try ClassAssignmentsCoreDataModel.context.execute(classesDeleteRequest)
      try ClassAssignmentsCoreDataModel.context.execute(assignmentsDeleteRequest)
    } catch let error as NSError {
      print("error during deletion \(error.localizedDescription)")
    }
    
  }
  
  func loadAllDatabaseData(isLoaded: Binding<Bool>)
  {
    emptyDB()
    
//    loadTeacherDatasetFromJSON()
//    loadAssignmentDatasetFromJSON()
//    loadStudentDatasetFromJSON()
//    loadSchoolClassesDatasetFromJSON()
    
    //NOTE: This is just one of MANY ways to accomplish this!  OperationQueues, for example, could be used.
    
    loadJSON(from: "http://159.203.191.136/resources/students.json", for: Student.self, completion: { items in
      items.forEach({ student in _ = student.convertToManagedObject() })

      loadJSON(from: "http://159.203.191.136/resources/assignments.json", for: Assignment.self, completion: { items in
        items.forEach({ assignment in _ = assignment.convertToManagedObject() })
        
        loadJSON(from: "http://159.203.191.136/resources/teachers.json", for: Teacher.self, completion: { items in
          items.forEach({ teacher in _ = teacher.convertToManagedObject() })
 
          loadJSON(from: "http://159.203.191.136/resources/courses.json", for: CourseClass.self, completion: { items in
            items.forEach({ courseClass in _ = courseClass.convertToManagedObject() })
            do {
              try ClassAssignmentsCoreDataModel.context.save()
            } catch {
              print("Error saving student to core data \(error.localizedDescription)")
            }
            self.assign(teacher: "rsteele3", toCourseClass: Courses.Fall2020_605_687.rawValue)
            isLoaded.wrappedValue = true
          })
        })
        
      })
      
    })
  }
  
  func loadJSON<T: Codable>(from urlString: String, for: T.Type, completion: @escaping ([T]) -> ())
  {
    print("url is \(urlString)")
    guard let url = URL(string: urlString) else {
      print("Error reaching requested URL \(urlString)")
      fatalError()
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      
      guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
        print("bad response code \((response as! HTTPURLResponse).statusCode)")
        return
      }
      
      guard let data = data else { print("nil data"); return }

      do {
        let jsonObjects: [T] = try JSONDecoder().decode([T].self, from: data)
        print("number of objects \(jsonObjects.count)")
        completion(jsonObjects)
      }
      catch let error as NSError {
        print("Error decoding the data from the string \(error)")
      }
    }
    
    task.resume()
  }
  
  func loadStudentDatasetFromJSON() {
      
    guard let students = classAssignmentTestData.students else {
      return print("Error loading students")
    }
    
    students.forEach({ student in _ = student.convertToManagedObject() })
    
    do {
      try ClassAssignmentsCoreDataModel.context.save()
    } catch {
      print("Error saving student to core data \(error.localizedDescription)")
    }
  }
    
  func loadTeacherDatasetFromJSON() {
    
    guard let teachers = classAssignmentTestData.teachers else {
      return print("Error loading teachers")
    }
    
    teachers.forEach({ teacher in _ = teacher.convertToManagedObject() })
    
    do {
      try ClassAssignmentsCoreDataModel.context.save()
    } catch {
      print("Error saving teacher to core data \(error)")
    }
  }
  
  func loadAssignmentDatasetFromJSON() {
    
    guard let assignments = classAssignmentTestData.assignments else {
      return print("Error loading assignments ")
    }
    
    assignments.forEach({ assignment in _ = assignment.convertToManagedObject() })
    
    do {
      try ClassAssignmentsCoreDataModel.context.save()
    } catch {
      print("Error saving assignment to core data \(error)")
    }
  }
  
  func loadSchoolClassesDatasetFromJSON() {
    
    guard let schoolClasses = classAssignmentTestData.schoolClasses else {
      return print("Error loading school classes")
    }
    schoolClasses.forEach({ schoolClass in _ = schoolClass.convertToManagedObject() })
    
    do {
      try ClassAssignmentsCoreDataModel.context.save()
    } catch {
      print("Error saving school class to core data \(error)")
    }
    
  }
  
  
  //Methods to get values from the database (via fetch requests)
  static func getStudentWith(jhed: String) -> StudentEntity?
  {
    let request = ClassAssignmentsCoreDataModel.context.persistentStoreCoordinator?.managedObjectModel.fetchRequestFromTemplate(withName: "StudentByJHED", substitutionVariables: ["JHED" : jhed])
    
    do {
      let student = try ClassAssignmentsCoreDataModel.context.fetch(request!).first as! StudentEntity
      return student
    } catch {
      print("student fetch failed")
      return nil
    }
  }
  
  /// Returns a `CourseClassEntity` for a given `name`
  /// - Parameter name: the name of the course
  /// - Returns: the optioanl `CourseClassEntity` corresponding to that name
  static func getCourseClassWith(name: String) -> CourseClassEntity?
  {
    let request: NSFetchRequest<CourseClassEntity> = CourseClassEntity.fetchRequest()
    request.predicate = NSPredicate(format: "courseClassName == %@", name)
    
    do {
      let courseClass = try ClassAssignmentsCoreDataModel.context.fetch(request).first
      return courseClass
    } catch {
      print("school class fetch failed")
      return nil
    }
  }
  
  /// Returns an AssignmentEntity for a given UUID
  /// - Parameter uuid: the UUID to search for
  /// - Returns: the optional `AssignmentEntity` for the given UUID
  static func getAssignmentWith(uuid: UUID) -> AssignmentEntity?
  {
    let request: NSFetchRequest<AssignmentEntity> = AssignmentEntity.fetchRequest()
    request.predicate = NSPredicate(format: "id == %@", uuid.uuidString)
    
    do {
      let assignment = try ClassAssignmentsCoreDataModel.context.fetch(request).first
      return assignment
    } catch {
      print("Assignment fetch failed")
      return nil
    }
  }
  
  /// Makes an relationship between the teacher that has the provided `jhed` and the course class for the given name
  /// - Parameters:
  ///   - jhed: the JHED for the teacher
  ///   - courseClassName: the course name to associate with the teacher
  func assign(teacher jhed: String, toCourseClass courseClassName: String)
  {
    let teacherRequest: NSFetchRequest<TeacherEntity> = TeacherEntity.fetchRequest()
    teacherRequest.predicate = NSPredicate(format: "jhed == %@", jhed)
    
    let schoolClassRequest: NSFetchRequest<CourseClassEntity> = CourseClassEntity.fetchRequest()
    schoolClassRequest.predicate = NSPredicate(format: "courseClassName == %@", courseClassName)
    do {
      let teacher = try ClassAssignmentsCoreDataModel.context.fetch(teacherRequest).first!
      let courseClass = try ClassAssignmentsCoreDataModel.context.fetch(schoolClassRequest).first!
      //adds this course class to the teacher's "activelyTeaching" array
      teacher.addToActivelyTeaching(courseClass)
      try ClassAssignmentsCoreDataModel.context.save()
    } catch {
      print("Assignment of teacher to class failed")
    }
  }
  
  func assign(student jhed: String, toCourseClass courseClassName: String)
  {
    let studentRequest: NSFetchRequest<StudentEntity> = StudentEntity.fetchRequest()
    studentRequest.predicate = NSPredicate(format: "jhed == %@", jhed)
    
    let courseClassRequest: NSFetchRequest<CourseClassEntity> = CourseClassEntity.fetchRequest()
    courseClassRequest.predicate = NSPredicate(format: "courseClassName == %@", courseClassName)
    do {
      let student = try ClassAssignmentsCoreDataModel.context.fetch(studentRequest).first!
      let courseClass = try ClassAssignmentsCoreDataModel.context.fetch(courseClassRequest).first!
      student.addToClasses(courseClass)
      try ClassAssignmentsCoreDataModel.context.save()
    } catch {
      print("Assignment of student to class failed")
    }
    
  }
  
  func assign(assignmentGrade: AssignmentGrade, toStudent jhed: String)
  {
    let studentRequest: NSFetchRequest<StudentEntity> = StudentEntity.fetchRequest()
    studentRequest.predicate = NSPredicate(format: "jhed == %@", jhed)
    
    let assignmentGradeEntity = assignmentGrade.convertToManagedObject()
    
    do {
      let student = try ClassAssignmentsCoreDataModel.context.fetch(studentRequest).first!
      student.addToAssignmentGrades(assignmentGradeEntity)
      try ClassAssignmentsCoreDataModel.context.save()
    } catch {
      print("Assignment of assignment to student failed")
    }
    
  }
}
