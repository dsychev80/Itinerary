//
//  TripModel.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/4/20.
//

import UIKit

class TripModel {
    let id: UUID
    var title: String
    var image: UIImage?
    
    init(title: String, image: UIImage? = nil) {
        id = UUID()
        self.title = title
        self.image = image
    }
}
