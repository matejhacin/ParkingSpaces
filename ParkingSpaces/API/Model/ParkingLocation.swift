//
//  Location.swift
//  ParkingSpaces
//
//  Created by Matej Hacin on 20/09/2017.
//  Copyright © 2017 Matej Hacin. All rights reserved.
//

import Foundation

class ParkingLocation: JSONInitializable {
    
    var id: Int?
    var distance: Double?
    var title: String?
    var description: String?
    var currency: String?
    var pricePerHour: Double?
    var pricePerDay: Double?
    var pricePerWeek: Double?
    var pricePerMonth: Double?
    var lat: Double?
    var lng: Double?
    var averageRating: Double?
    var cancellationPolicy: String?
    var fascilityDescriptions: [String]?
    var thumbnailUrl: String?
    
    required init(from dictionary: NSDictionary) {
        id = dictionary["id"] as? Int
        distance = dictionary["distance"] as? Double
        title = dictionary["title"] as? String
        description = dictionary["description"] as? String
        
        if let currencyData = dictionary["currency"] as? NSDictionary {
            currency = currencyData["symbol"] as? String
        }
        
        pricePerHour = dictionary["price_hour"] as? Double
        pricePerDay = dictionary["price_day"] as? Double
        pricePerWeek = dictionary["price_week"] as? Double
        pricePerMonth = dictionary["price_month"] as? Double
        lat = dictionary["address_lat"] as? Double
        lng = dictionary["address_lng"] as? Double
        averageRating = dictionary["review_average"] as? Double
        cancellationPolicy = dictionary["cancellation_policy_type"] as? String
        
        if let fascilityData = dictionary["facilities"] as? NSArray {
            fascilityDescriptions = []
            for case let item as NSDictionary in fascilityData {
                if let description = item["description"] as? String {
                    fascilityDescriptions?.append(description)
                }
            }
        }
        
        if let gallery = dictionary["gallery"] as? NSArray {
            guard gallery.count > 0 else { return }
            guard let firstImageData = gallery[0] as? NSDictionary else { return }
            guard let firstImageThumbnailData = firstImageData["normal"] as? NSDictionary else { return }
            
            thumbnailUrl = firstImageThumbnailData["url"] as? String
        }
        
    }
    
}
