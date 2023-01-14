//
//  ChatHelper.swift
//  MyPOCs
//
//  Created by Dylan Perry on 12/30/22.
//

import Foundation
import Combine

class ChatHelper : ObservableObject {
  var didChange = PassthroughSubject<Void, Never>()
  private let service: OpenAIChatService = OpenAIChatService()
  @Published var realTimeMessages = ChatHelper.Messages()
  @Published var realTimeImages: [ImageMessage] = []
    
  public init() {}
  
  func sendMessage(_ chatMessage: Message, type: ChatType = .text) async {
    realTimeMessages.append(chatMessage)
    didChange.send(())
    switch type {
    case .text:
      await askQuestionToService(chatMessage.content)
    case .image:
      await generateImageFromService(chatMessage.content)
    }
  }
  
  private func generateImageFromService(_ message: String) async {
    do {
      let result = try await service.generateImage(prompt: message)
      let responseMessage = ImageMessage(url: result, user: User.User2, originalQuestion: message)
      realTimeImages.append(responseMessage)
      didChange.send(())
    } catch {
      print("Nothing worked!!!")
    }
  }
  
  private func askQuestionToService(_ message: String) async {
    do {
      let result = try await service.askQuestion(prompt: message)
      let responseMessage = Message(content: result, user: User.User2)
      realTimeMessages.append(responseMessage)
      didChange.send(())
    } catch ServiceError.invalidURL(let errorMessage) {
      let responseMessage = Message(content: errorMessage, user: User.User2)
      realTimeMessages.append(responseMessage)
      didChange.send(())
    } catch ServiceError.invalidRequestBody(let errorMessage) {
      let responseMessage = Message(content: errorMessage, user: User.User2)
      realTimeMessages.append(responseMessage)
      didChange.send(())
    }  catch ServiceError.invalidResponse(let errorMessage) {
      let responseMessage = Message(content: errorMessage, user: User.User2)
      realTimeMessages.append(responseMessage)
      didChange.send(())
    }  catch ServiceError.serverError(let errorMessage) {
      let responseMessage = Message(content: errorMessage, user: User.User2)
      realTimeMessages.append(responseMessage)
      didChange.send(())
    } catch {
      let responseMessage = Message(content: "It absolutely blew up. Things are very wrong.", user: User.User2)
      realTimeMessages.append(responseMessage)
      didChange.send(())
    }
  }
}
extension ChatHelper {
  public enum ChatType {
    case image
    case text
  }
  
  static func Messages() -> [Message] {
    return [
      Message(content: "Consider me your personal assistant. Ask me any question, and I will do my best to answer!", user: User.User2),
    ]
  }
  
  static func ImageMessages() -> [ImageMessage] {
    return [
      ImageMessage(url: "https://oaidalleapiprodscus.blob.core.windows.net/private/org-OKHdVtD68VCU5yGEaovPBXmB/user-QtI8YczrKWO4VFREtvLMfj6K/img-9ZysHgSXxpl9iGWMNcQiFFO8.png?st=2023-01-01T16%3A12%3A56Z&se=2023-01-01T18%3A12%3A56Z&sp=r&sv=2021-08-06&sr=b&rscd=inline&rsct=image/png&skoid=6aaadede-4fb3-4698-a8f6-684d7786b067&sktid=a48cca56-e6da-484e-a814-9c849652bcb3&skt=2023-01-01T14%3A45%3A16Z&ske=2023-01-02T14%3A45%3A16Z&sks=b&skv=2021-08-06&sig=krEHHvA7k7Lr%2BTHv8h/b95C%2BMVwcli7QmLvnCYc5BaY%3D", user: User.User2),
    ]
  }
}
