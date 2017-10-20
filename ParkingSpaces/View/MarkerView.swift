//
//  MarkerView.swift
//  ParkingSpaces
//
//  Created by Matej Hacin on 21/09/2017.
//  Copyright © 2017 Matej Hacin. All rights reserved.
//

import Foundation
import UIKit

class MarkerView: UIView {
    
    @IBOutlet weak var label: UILabel!
    
    class func loadFromNib() -> MarkerView {
        return Bundle.main.loadNibNamed("MarkerView", owner: self, options: nil)![0] as! MarkerView
    }
    
}
