//
//  TwilioService.swift
//  Dyls-Desk
//
//  Created by Dylan Perry on 1/14/23.
//

import Foundation

final class TwilioService {
  private let url = "https://lambda.dfperry-aws.io/twilio/text"
  func sendMessage(phoneNumber: String, message: String) async -> Result<TwilioResponse, TwilioError> {
    guard !message.isEmpty else { return .failure(.invalidIput(message: "No message provided"))}
    let phoneNumberResult = PhoneNumberHelper.preparePhoneNumber(phoneNumber: phoneNumber)
    switch phoneNumberResult {
    case .success(let newPhoneNumber):
      return await makeRequest(phoneNumber: newPhoneNumber, message: message)
    default:
      return .failure(.invalidIput(message: "Invalid phone number"))
    }
  }
  
  private func makeRequest(phoneNumber: String, message: String) async -> Result<TwilioResponse, TwilioError>{
    
    // Prepare the request
    let twilioRequestBody = TwilioRequest(message: message, phoneNumber: phoneNumber)
    guard let requestURL = URL(string: url) else {
      return .failure(.generic(message: "Could not convert URL"))
    }
    var request = URLRequest(url: requestURL)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    guard let httpBody = try? JSONEncoder().encode(twilioRequestBody) else {
      return .failure(.generic(message: "Could not convert requestBody to JSON"))
    }
    request.httpBody = httpBody
    // Make Request
    do  {
      let (data, _) = try await URLSession.shared.data(for: request)
      guard let twilioResponse = try? JSONDecoder().decode(TwilioResponse.self, from: data) else {
        return .failure(.invalidResponse(message: "Could not serialize response into Swift object"))
      }
      return .success(twilioResponse)
    } catch {
      print(error)
      return .failure(.invalidResponse(message: "Could not get response from service"))
    }
  }
}
