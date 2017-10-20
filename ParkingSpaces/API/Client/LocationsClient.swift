//
//  LocationsClient.swift
//  ParkingSpaces
//
//  Created by Matej Hacin on 20/09/2017.
//  Copyright © 2017 Matej Hacin. All rights reserved.
//

import Foundation
import RxAlamofire
import Alamofire
import RxSwift

class LocationsClient {
    
    // MARK: Observables
    
    func locations() -> Observable<SearchResult> {
        return Alamofire.SessionManager.default.rx.json(.post, "REPLACE_ME_WITH_ENDPOINT", parameters: exampleSearch, encoding: JSONEncoding.default, headers: nil).convertToModel()
    }
    
    // MARK: Private
    
    private var exampleSearch: [String: Any] {
        return [
            "near" : [
                "lat" : "51.5560241",
                "lng" : "-0.2817075",
                "distance" : "100"
            ]
        ]
    }
    
}
