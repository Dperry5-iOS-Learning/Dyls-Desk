//
//  ImageGenerationView.swift
//  Dyls Desk
//
//  Created by Dylan Perry on 1/11/23.
//

import SwiftUI

struct ImageGenerationView: View {
  @State var typingMessage: String = ""
  @State var isAsking: Bool = false
  @EnvironmentObject var chatHelper: ChatHelper
  @Environment(\.colorScheme) var colorScheme
  
  var body: some View {
    NavigationView {
      ScrollViewReader { proxy in
        ScrollView {
          MessageView(currentMessage: chatHelper.realTimeMessages[0])
          ForEach(chatHelper.realTimeImages, id: \.self) { msg in
            ImageView(currentMessage: msg)
          }
          .textSelection(.enabled)
        }
      }
      .safeAreaInset(edge: .bottom, content: {
        HStack {
          TextField("Message...", text: $typingMessage)
            .lineLimit(1...10)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .frame(minHeight: CGFloat(30))
          
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
          ProgressView()
            .scaleEffect(8)
            .progressViewStyle(CircularProgressViewStyle(tint: Color.teal))
        }
      }
      .padding()
      .navigationBarTitle(Text("Image Generation"), displayMode: .inline)
    }
  }
}

extension ImageGenerationView {
  func sendMessage() async {
    let question = typingMessage
    typingMessage = ""
    UIApplication.shared.endEditing()
    isAsking = true
    await chatHelper.sendMessage(Message(content: question, user: User.User1), type: .image)
    isAsking = false
  }
}

struct ImageGenerationView_Previews: PreviewProvider {
    static var previews: some View {
        ImageGenerationView()
    }
}

