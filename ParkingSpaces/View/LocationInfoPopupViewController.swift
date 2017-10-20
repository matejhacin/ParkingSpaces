//
//  LocationInfoPopupViewController.swift
//  ParkingSpaces
//
//  Created by Matej Hacin on 21/09/2017.
//  Copyright © 2017 Matej Hacin. All rights reserved.

import Foundation
import UIKit
import AlamofireImage

class LocationInfoPopupViewController: UIViewController {
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var location: ParkingLocation?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupUi()
        renderLocationDetails()
    }
    
    // MARK: Private
    
    private func setupUi() {
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor(red: 0.02660920843, green: 0.7001220584, blue: 0.1377908885, alpha: 1.0).cgColor
        
        imageView.layer.cornerRadius = 16
    }
    
    private func renderLocationDetails() {
        guard let location = location else { return }
        
        if let thumbnailUrl = location.thumbnailUrl, let url = URL(string: thumbnailUrl) {
            imageView.af_setImage(withURL: url)
        }
        
        titleLabel.text = location.title
        descriptionLabel.text = location.description
    }
    
}
