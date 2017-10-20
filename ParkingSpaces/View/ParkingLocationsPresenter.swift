//
//  ParkingLocationsPresenter.swift
//  ParkingSpaces
//
//  Created by Matej Hacin on 20/09/2017.
//  Copyright © 2017 Matej Hacin. All rights reserved.
//

import Foundation

class ParkingLocationsPresenter {
    
    private var locationsClient: LocationsClient?
    var view: ParkingLocationsView?
    
    init(withClient client: LocationsClient) {
        locationsClient = client
    }
    
    // MARK: Public
    
    public func loadLocations() {
        view?.showLoadingState(true)
        
        let _ = locationsClient?.locations().subscribe(onNext: { [weak self] (searchResult) in
            guard let welf = self else { return }
            
            welf.view?.showLoadingState(false)
            welf.view?.addLocationsToMap(welf.createLocationsDictionary(searchResult.parkingLocations))
        }, onError: { [weak self] (error) in
            self?.view?.showLoadingState(false)
            self?.view?.showErrorState()
        })
    }
    
    // MARK: Private
    
    private func createLocationsDictionary(_ locations: [ParkingLocation]) -> [String: ParkingLocation] {
        var parkingLocations: [String: ParkingLocation] = [:]
        
        for location in locations {
            if let id = location.id {
                parkingLocations[String(id)] = location
            }
        }
        
        return parkingLocations
    }
    
}
