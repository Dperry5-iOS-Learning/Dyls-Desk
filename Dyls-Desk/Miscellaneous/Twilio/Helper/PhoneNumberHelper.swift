//
//  PhoneNumberHelper.swift
//  Dyls-Desk
//
//  Created by Dylan Perry on 1/14/23.
//

import Foundation
struct PhoneNumberHelper {
  static func preparePhoneNumber(phoneNumber: String) -> Result<String, PhoneNumberError> {
    var newPhoneNumber = phoneNumber.replacingOccurrences(of: "-", with: "")
    newPhoneNumber = newPhoneNumber.trimmingCharacters(in: .letters)
    if newPhoneNumber.hasPrefix("+1") {
      if newPhoneNumber.count == 12 {
        return .success(newPhoneNumber)
      } else {
        return .failure(.invalidPhoneNumber(message: "Incorrect number of characters"))
      }
    } else {
      if newPhoneNumber.count == 10 {
        newPhoneNumber = "+1\(newPhoneNumber)"
        return .success(newPhoneNumber)
      } else {
        return .failure(.invalidPhoneNumber(message: "Incorrect number of characters"))
      }
    }
  }
}
