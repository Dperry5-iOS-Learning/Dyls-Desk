//
//  MiscDestinationViewModel.swift
//  Dyls Desk
//
//  Created by Dylan Perry on 1/11/23.
//

import Foundation
struct MiscDestinationViewModel: Hashable, Identifiable {
  let id = UUID()
  let displayName: String
  let destination: MiscDestination
}
