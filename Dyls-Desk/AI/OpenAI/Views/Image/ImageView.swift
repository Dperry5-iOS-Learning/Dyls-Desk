//
//  ImageView.swift
//  Dyls Desk
//
//  Created by Dylan Perry on 1/11/23.
//

import SwiftUI

struct ImageView: View {
  var currentMessage: ImageMessage
  var body: some View {
      HStack(alignment: .bottom, spacing: 15) {
          if !currentMessage.user.isCurrentUser {
            Image(systemName: currentMessage.user.avatar)
              .resizable()
              .frame(width: 40, height: 40, alignment: .center)
              .cornerRadius(20)
          } else {
              Spacer()
          }
        ContentImageView(imageURL: currentMessage.url,
                         isCurrentUser: currentMessage.user.isCurrentUser, originalQuestion: currentMessage.originalQuestion ?? "Couldnt retrieve original question")
      }
  }
}

struct ImageView_Previews: PreviewProvider {
  static var previews: some View {
    ImageView(currentMessage: ChatHelper.ImageMessages()[0])
  }
}
