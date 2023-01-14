//
//  TwilioResponse.swift
//  Dyls-Desk
//
//  Created by Dylan Perry on 1/14/23.
//

import Foundation


struct TwilioResponse: Codable {
  let sid: String
  let toNumber: String
  let from: String
  let body: String
}
