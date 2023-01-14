//
//  DylsDesk.swift
//  Dyls Desk
//
//  Created by Dylan Perry on 1/11/23.
//

import SwiftUI

struct DylsDesk: View {
    var body: some View {
      TabView {
        AIView()
          .tabItem {
            Image(systemName: "brain.head.profile")
            Text("AI")
          }
        MiscellaneousView()
          .tabItem {
            Image(systemName: "scribble.variable")
            Text("Misc")
          }
        POCView()
          .tabItem {
            Image(systemName: "ipad.and.iphone")
            Text("UI")
          }
      }
      .accentColor(.teal)
    }
}

struct DylsDesk_Previews: PreviewProvider {
    static var previews: some View {
      DylsDesk()
    }
}
