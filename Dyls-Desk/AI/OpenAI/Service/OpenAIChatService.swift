//
//  OpenAIChatService.swift
//  Dyls Desk
//
//  Created by Dylan Perry on 1/11/23.
//

import Foundation

class OpenAIChatService {
  private let lambdaURL = "https://lambda.dfperry-aws.io/openAIPOC"
  
  public func askQuestion(prompt: String) async throws -> String {
    let requestBody = LambdaRequest(prompt: prompt)
    guard let requestURL = URL(string: lambdaURL) else {
      throw ServiceError.invalidURL("Oh no, couldn't talk to the service")
    }
    var request = URLRequest(url: requestURL)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    guard let httpBody = try? JSONEncoder().encode(requestBody) else {
      throw ServiceError.invalidRequestBody("Invalid Request body - cannot serialize")
    }
    request.httpBody = httpBody
    
    do  {
      let (data, _) = try await URLSession.shared.data(for: request)
      guard let lambdaResponse = try? JSONDecoder().decode(LambdaResponse.self, from: data) else {
        throw ServiceError.invalidResponse("Invalid response recieved from service")
      }
      return lambdaResponse.message
    } catch {
      print(error)
      throw ServiceError.serverError("Server failure!")
    }
  }
  
  public func generateImage(prompt: String) async throws -> String {
    let requestBody = LambdaRequest(prompt: prompt)
    let imageRequestURL = "\(lambdaURL)/image"
    guard let requestURL = URL(string: imageRequestURL) else {
      throw ServiceError.invalidURL("Oh no, couldn't talk to the service")
    }
    var request = URLRequest(url: requestURL)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpMethod = "POST"
    guard let httpBody = try? JSONEncoder().encode(requestBody) else {
      throw ServiceError.invalidRequestBody("Invalid Request body - cannot serialize")
    }
    request.httpBody = httpBody
    
    do  {
      let (data, _) = try await URLSession.shared.data(for: request)
      guard let lambdaResponse = try? JSONDecoder().decode(LambdaImageResponse.self, from: data) else {
        throw ServiceError.invalidResponse("Invalid response recieved from service")
      }
      return lambdaResponse.url
    } catch {
      print(error)
      throw ServiceError.serverError("Server failure!")
    }
  }
}
