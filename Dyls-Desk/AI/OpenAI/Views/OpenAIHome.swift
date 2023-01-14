//
//  OpenAIHome.swift
//  Dyls Desk
//
//  Created by Dylan Perry on 1/11/23.
//

import SwiftUI

struct OpenAIHome: View {
  var body: some View {
    NavigationView {
      List {
        NavigationLink(
          destination: ChatView().environmentObject(ChatHelper()),
          label: {
            Text("Chat Bot")
          }
        )
        
        NavigationLink(
          /// 2
          destination: ImageGenerationView().environmentObject(ChatHelper()),
          /// 3
          label: {
              Text("Image Generation")
          }
        )
      }
      .listStyle(.plain)
      .padding()
    }
    .navigationTitle("OpenAI POCs")
  }

}

struct OpenAIHome_Previews: PreviewProvider {
    static var previews: some View {
        OpenAIHome()
    }
}
