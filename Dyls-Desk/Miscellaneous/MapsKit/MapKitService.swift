//
//  MapKitService.swift
//  Dyls-Desk
//
//  Created by Dylan Perry on 2/9/23.
//

import Foundation
import MapKit


//  4420 Lake Boone Trail, Raleigh, NC 27607

class MapKitService {
  func getPhoneNumber(textToSearch: String, callback: @escaping (String) -> Void) {
    let searchRequest = MKLocalSearch.Request()
    searchRequest.naturalLanguageQuery = textToSearch
    let search = MKLocalSearch(request: searchRequest)
    search.start { response, error in
        guard let response = response else {
            print("Error: \(error?.localizedDescription ?? "Unknown error").")
            return
        }
      
        for item in response.mapItems {
            print(item.phoneNumber ?? "No phone number.")
        }
      callback(response.mapItems.first?.phoneNumber ?? "No Phone Number found")
    }
    
  }
}
