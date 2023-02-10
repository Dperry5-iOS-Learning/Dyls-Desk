//
//  MiscellaneousView.swift
//  Dyls Desk
//
//  Created by Dylan Perry on 1/11/23.
//

import SwiftUI

struct MiscellaneousView: View {
  private let destinations: [MiscDestinationViewModel]
  
  init() {
    self.destinations = [
      MiscDestinationViewModel(displayName: "Twilio", destination: .twilio),
      MiscDestinationViewModel(displayName: "Firebase for Softball", destination: .firebase),
      MiscDestinationViewModel(displayName: "MapKit POC", destination: .mapKit)
    ]
  }
  
  var body: some View {
    NavigationStack {
      List(destinations) { destination in
        NavigationLink(destination.displayName, value: destination)
      }
      .listStyle(.plain)
      .navigationDestination(for: MiscDestinationViewModel.self) { viewModel in
        switch viewModel.destination {
        case .twilio:
          TwilioHome()
        case .firebase:
          FirebaseSoftballHome()
        case .mapKit:
          MapsKitView()
        }
      }
      .navigationTitle("Misc Things")
    }
  }
}

struct MiscellaneousView_Previews: PreviewProvider {
    static var previews: some View {
        MiscellaneousView()
    }
}
