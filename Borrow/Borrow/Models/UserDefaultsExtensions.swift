//
//  UserDefaultsExtensions.swift
//  Borrow
//
//  Created by Casey on 4/4/21.
//

import Foundation

extension LoginScreen {
  
  func saveUserName(userName: String) {
    UserDefaults.standard.set(userName.lowercased(), forKey: "username")
    
  }
  
}

extension CourseClass {
  
  func addEnrolledClass(newClass: CourseClass) {
    
    var currentClasses = UserDefaults.standard.array(forKey: "enrolledClasses")
    currentClasses?.append(newClass)
    UserDefaults.standard.set(currentClasses, forKey: "enrolledClasses")
    
  }
}
