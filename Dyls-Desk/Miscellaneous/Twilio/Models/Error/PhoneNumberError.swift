//
//  PhoneNumberError.swift
//  Dyls-Desk
//
//  Created by Dylan Perry on 1/14/23.
//

import Foundation

enum PhoneNumberError: Error {
  case invalidPhoneNumber(message: String)
}
