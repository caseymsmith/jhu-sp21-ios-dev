import UIKit

//Code from the lecture
enum Courses: String, Codable {
  
  case Fall2020_605_687 = "605.687 F2020"
  case Fall2020_615_641 = "615.641 F2020"
  case Fall2020_525_608 = "525.608 F2020"
  case Fall2020_675_600 = "675.600 F2020"
  case Fall2020_645_662 = "645.662 F2020"
  
}

enum EdDegree: String, Codable {
  
  case PhD = "PhD"
  case Masters = "Masters"
  case Bachelors = "Bachelors"
  case Associate = "Associate"
  
}

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

enum AssignmentType: String, Codable {
  
  case DevelopmentLog = "Development Log"
  case WeeklyCompletion = "Weekly Completion"
  case FinalProject = "Final Project"
  
}

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

struct AssignmentGrade: Codable {
  
  let assignment: Assignment
  let grade: Double
  let graderComments: String
  
}

struct CourseClass: Codable {
  
  public var id: UUID = UUID()
  let className: Courses
  var students: [Student]
  var currentTeacher: Teacher?
  var pastTeachers: [Teacher]
  
}

//Property for the program to which the student belongs to
// but NOT as a String in the Student struct
enum ProgramType: String, Codable {
  case computerScience = "Computer Science"
  case engineering = "Engineering"
  case engineeringManagement = "Engineering Management"
  case electricalCompEngineering = "Electrical and Computer Engineering"
}

struct Student: Codable {
  
  let name: String
  let address: String
  let email: String
  let jhed: String
  let imageName: String
  let program: ProgramType
  let assignmentGrades: [AssignmentGrade]
  var averageGrade: Double?
}

extension Student {
    mutating func calculateAssignmentAverage() {
        //0.0 is initial value of grade average 0.
        self.averageGrade = self.assignmentGrades.reduce(0.0) {
            //$0 = 0.0 at first, then $1 is 0th index
            return $0 + $1.grade/Double(assignmentGrades.count)
        }
    }
}

let decoder = JSONDecoder()

//loads json files
let studentFileUrl = Bundle.main.url(forResource: "student", withExtension: "json")
let classesFileUrl = Bundle.main.url(forResource: "classes", withExtension: "json")
let assignmentsFileUrl = Bundle.main.url(forResource: "assignments", withExtension: "json")
let teacherFileUrl = Bundle.main.url(forResource: "teacher", withExtension: "json")

//for testing:
//print(studentJsonString)


let studentJsonString = try String(contentsOf: studentFileUrl!, encoding: String.Encoding.utf8)
let studentJsonData = Data(studentJsonString.utf8)
let classesJsonString = try! String(contentsOf: classesFileUrl!, encoding: String.Encoding.utf8)
let classesJsonData = Data(classesJsonString.utf8)
let assignmentsJsonString = try! String(contentsOf: assignmentsFileUrl!, encoding: String.Encoding.utf8)
let assignmentsJsonData = Data(assignmentsJsonString.utf8)
let teacherJsonString = try! String(contentsOf: teacherFileUrl!, encoding: String.Encoding.utf8)
let teacherJsonData = Data(teacherJsonString.utf8)

do {
    let student = try decoder.decode([Student].self, from: studentJsonData)
    let aClass = try decoder.decode([CourseClass].self, from: classesJsonData)
    let assignment = try decoder.decode([Assignment].self, from: assignmentsJsonData)
    let teacher = try decoder.decode([Teacher].self, from: teacherJsonData)

    //Make sure you output at least one element of each data structure to make sure it loaded correctly
    print(student[0].name)
    print(aClass[0].className)
    print(assignment[0].assignmentType)
    print(teacher[0].name)

} catch {
    //outputs any errors when reading from JSON files
    print(error.localizedDescription)
}
