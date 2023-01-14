//
//  LoadingView.swift
//  Dyls-Desk
//
//  Created by Dylan Perry on 1/14/23.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
      ProgressView()
        .scaleEffect(8)
        .progressViewStyle(CircularProgressViewStyle(tint: Color.teal))    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
