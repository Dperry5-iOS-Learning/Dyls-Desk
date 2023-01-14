//
//  ChatView.swift
//  Dyls Desk
//
//  Created by Dylan Perry on 1/11/23.
//

import SwiftUI
import Combine

struct ChatView: View {
  @State var typingMessage: String = ""
  @State var isAsking: Bool = false
  @EnvironmentObject var chatHelper: ChatHelper
  @Environment(\.colorScheme) var colorScheme
  
  var body: some View {
    NavigationView {
      ScrollViewReader { proxy in
        ScrollView {
          ForEach(chatHelper.realTimeMessages, id: \.self) { msg in
            MessageView(currentMessage: msg)
          }
          .textSelection(.enabled)
        }
      }
      .safeAreaInset(edge: .bottom, content: {
        HStack {
          VerticalExpandingTextField(input: $typingMessage)
          
          Button("Send") {
            Task {
              await sendMessage()
            }
          }
        }
        .frame(minHeight: CGFloat(50))
        .background(colorScheme == .dark ? .black : .white)
      })
      .overlay {
        if isAsking {
          LoadingView()
        }
      }
      .padding()
      .navigationBarTitle(Text("AI Chat"), displayMode: .inline)
    }
  }
}

extension ChatView {
  func sendMessage() async {
    let question = typingMessage
    typingMessage = ""
    UIApplication.shared.endEditing()
    isAsking = true
    await chatHelper.sendMessage(Message(content: question, user: User.User1))
    isAsking = false
  }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}
