//
//  ImageMessage.swift
//  OpenAIChatPOC
//
//  Created by Dylan Perry on 1/1/23.
//

import Foundation

struct ImageMessage: Hashable {
    var url: String
    var user: User
    var originalQuestion: String? = nil
}
