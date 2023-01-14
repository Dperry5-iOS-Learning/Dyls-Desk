//
//  User.swift
//  Dyls Desk
//
//  Created by Dylan Perry on 1/11/23.
//

import Foundation
struct User: Hashable {
    var name: String
    var avatar: String
    var isCurrentUser: Bool = false
}

extension User {
  static let User1: User = User(name: "Dylan", avatar: "person", isCurrentUser: true)
  static let User2: User = User(name: "AI Bot", avatar: "brain")
}
