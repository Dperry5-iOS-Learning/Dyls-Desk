//
//  TwilioView.swift
//  Dyls Desk
//
//  Created by Dylan Perry on 1/11/23.
//

import SwiftUI

struct TwilioHome: View {
  @State
  private var phoneNumber: String = ""
  @State
  private var messageToSend: String = ""
  @State
  private var isSending: Bool = false
  @State
  private var showSuccessMessage: Bool = false
  @State
  private var showFailureMessage: Bool = false

  private let service = TwilioService()
  
  var body: some View {
    VStack {
      // Phone Number Piece
      VStack {
        HStack {
          Text("Phone Number:")
            .fontWeight(.bold)
            .font(.caption)
          Spacer()
        }
        TextField("Phone Number", text: $phoneNumber, prompt: Text("Enter a US phone number..."))
          .textFieldStyle(.roundedBorder)
          .keyboardType(.phonePad)
      }
      .padding()
      // Send Message
      Spacer()
    }
    .safeAreaInset(edge: .bottom, content: {
      VStack {
        HStack {
          Text("Message:")
            .fontWeight(.bold)
            .font(.caption)
          Spacer()
        }
        HStack {
          VerticalExpandingTextField(input: $messageToSend)
          Button("Send") {
            Task {
              await sendMessage()
            }
          }
        }
      }
      .padding()
    })
    .overlay(content: {
      if isSending {
        LoadingView()
      }
    })
    .alert(isPresented: $showSuccessMessage) {
      Alert(
          title: Text("Message Sent!"),
          message: Text("The Message was: \(messageToSend)"),
          dismissButton: Alert.Button.default(Text("OK"), action: {
            alertDismissed()
          })
      )
    }
    .alert(isPresented: $showFailureMessage) {
      Alert(
          title: Text("Message Sent!"),
          message: Text("The Message wasn't sent. Please try again."),
          dismissButton: Alert.Button.default(Text("OK"), action: {
            alertDismissed()
          })
      )
    }
    .padding()
    .navigationTitle("Use Twilio")
  }
}

extension TwilioHome {
  private func sendMessage() async {
    isSending.toggle()
    let result = await service.sendMessage(phoneNumber: phoneNumber, message: messageToSend)
    switch result {
    case .success:
      isSending.toggle()
      showSuccessMessage.toggle()
    default:
      isSending.toggle()
      showFailureMessage.toggle()
    }
  }
  
  private func alertDismissed() {
    self.phoneNumber = ""
    self.messageToSend = ""
  }
}

struct TwilioHome_Previews: PreviewProvider {
    static var previews: some View {
      TwilioHome()
    }
}
