//
//  TwilioRequest.swift
//  Dyls-Desk
//
//  Created by Dylan Perry on 1/14/23.
//

import Foundation


struct TwilioRequest: Codable {
    let message: String
    let phoneNumber: String
}
