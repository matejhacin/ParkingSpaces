//
//  Double+Round.swift
//  ParkingSpaces
//
//  Created by Matej Hacin on 21/09/2017.
//  Copyright © 2017 Matej Hacin. All rights reserved.
//

import Foundation

extension Double {
    
    // Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
    
}
