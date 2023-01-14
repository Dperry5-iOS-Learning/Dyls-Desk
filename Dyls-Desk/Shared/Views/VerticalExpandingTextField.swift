//
//  VerticalExpandingTextField.swift
//  Dyls-Desk
//
//  Created by Dylan Perry on 1/14/23.
//

import SwiftUI

struct VerticalExpandingTextField: View {
  var input: Binding<String>
  var body: some View {
    TextField("Message...", text: input, axis: .vertical)
      .lineLimit(1...10)
      .textFieldStyle(RoundedBorderTextFieldStyle())
      .frame(minHeight: CGFloat(30))
  }
}
