//
//  ContentImageView.swift
//  Dyls Desk
//
//  Created by Dylan Perry on 1/11/23.
//

import SwiftUI

struct ContentImageView: View {
  var imageURL: String
  var isCurrentUser: Bool
  var originalQuestion: String
  
  var body: some View {
    VStack {
      Text("Your question was: \(originalQuestion)")
        .font(.headline)
      AsyncImage(
        url: URL(string: imageURL),
        content: { image in
          image.resizable()
            .aspectRatio(contentMode: .fit)
            .frame(maxWidth: 500, maxHeight: 500)
        },
        placeholder: {
          ProgressView()
        }
      )
      
      Button {
        UIPasteboard.general.string = imageURL
      } label: {
        Text("Copy image URL")
          .foregroundColor(.white)
      }
      .buttonStyle(.borderedProminent)
    }
      .frame(maxHeight: .infinity)
      .fixedSize(horizontal: false, vertical: true)
      .padding(10)
      .foregroundColor(isCurrentUser ? Color.white : Color.black)
      .background(isCurrentUser ? Color.blue : Color(UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)))
      .cornerRadius(10)
  }
}

struct ContentImageView_Previews: PreviewProvider {
  static var previews: some View {
    ContentImageView(imageURL: "12345", isCurrentUser: true, originalQuestion: "yooo")
  }
}
