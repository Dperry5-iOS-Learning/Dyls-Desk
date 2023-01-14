//
//  AIView.swift
//  Dyls Desk
//
//  Created by Dylan Perry on 1/11/23.
//

import SwiftUI

struct AIView: View {
  private let destinations: [AIDestinationViewModel]
  
  init() {
    self.destinations = [
      AIDestinationViewModel(displayName: "OpenAI", destination: .openAI)
    ]
  }
  
    var body: some View {
      NavigationStack {
        List(destinations) { destination in
          NavigationLink(destination.displayName, value: destination)
        }
        .listStyle(.plain)
        .navigationDestination(for: AIDestinationViewModel.self) { viewModel in
          switch viewModel.destination {
          case .openAI:
            OpenAIHome()
          }
        }
        .navigationTitle("AI Projects")
      }
    }
}



struct AIView_Previews: PreviewProvider {
    static var previews: some View {
        AIView()
    }
}
