//
//  MapsKitView.swift
//  Dyls-Desk
//
//  Created by Dylan Perry on 2/9/23.
//

import SwiftUI

struct MapsKitView: View {
  @State
  var hasResult: Bool = false
  @State
  var textToSearch: String = ""
  @State
  var value: String = ""
  
  var body: some View {
    VStack {
      Text("Location Lookup")
      HStack {
        VerticalExpandingTextField(input: $textToSearch)
        Button("Send") {
          handleSearch()
        }
      }
      if hasResult {
        Text(value)
      }
    }
  }
}

extension MapsKitView {
  func handleSearch() {
    MapKitService().getPhoneNumber(textToSearch: textToSearch) { phoneNumber in
      print(phoneNumber)
      value = phoneNumber
      hasResult.toggle()
    }
  }
}

struct MapsKitView_Previews: PreviewProvider {
    static var previews: some View {
        MapsKitView()
    }
}
