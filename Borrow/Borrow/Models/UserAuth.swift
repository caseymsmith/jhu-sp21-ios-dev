//
//  UserAuth.swift
//  Borrow
//
//  Created by Casey on 4/4/21.
//

import Foundation

class UserAuth: ObservableObject {
  
  @Published var isLoggedIn = false
  
  func login() {
    self.isLoggedIn = true
  }
  
  func logout() {
    self.isLoggedIn = false
  }
}
