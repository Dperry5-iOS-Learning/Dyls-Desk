//
//  ServiceError.swift
//  Dyls Desk
//
//  Created by Dylan Perry on 1/11/23.
//

import Foundation

enum ServiceError: Error {
  case invalidURL(String)
  case invalidRequestBody(String)
  case serverError(String)
  case invalidResponse(String)
}
