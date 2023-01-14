//
//  UIApplication+.swift
//  Dyls Desk
//
//  Created by Dylan Perry on 1/11/23.
//

import Foundation
import SwiftUI

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
