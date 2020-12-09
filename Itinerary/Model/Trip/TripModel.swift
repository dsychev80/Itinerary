//
//  TripModel.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/4/20.
//

import UIKit

struct TripModel {
    let id: String
    var title: String
    var image: UIImage?
    var dayModels: [DayModel] = [DayModel]()
    
    init(title: String, image: UIImage? = nil, dayModels: [DayModel]? = nil) {
        id = UUID().uuidString
        self.title = title
        self.image = image
        
        if let dayModels = dayModels {
            self.dayModels = dayModels
        }
    }
}

