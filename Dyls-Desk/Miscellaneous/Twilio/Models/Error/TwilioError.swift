//
//  TwilioError.swift
//  Dyls-Desk
//
//  Created by Dylan Perry on 1/14/23.
//

import Foundation

public enum TwilioError: Error {
  case invalidIput(message: String)
  case invalidResponse(message: String)
  case generic(message: String)
}
