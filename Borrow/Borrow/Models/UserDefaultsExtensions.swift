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
