//
//  SearchResult.swift
//  ParkingSpaces
//
//  Created by Matej Hacin on 20/09/2017.
//  Copyright © 2017 Matej Hacin. All rights reserved.
//

import Foundation

class SearchResult: JSONInitializable {
    
    var parkingLocations: [ParkingLocation] = []
    
    required init(from dictionary: NSDictionary) {
        let data = dictionary.object(forKey: "data") as? NSArray
        
        for case let item as NSDictionary in data ?? [] {
            parkingLocations.append(ParkingLocation(from: item))
        }
    }
    
}
