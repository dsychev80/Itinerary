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
    var dayModels: [DayModel] = [DayModel]() {
        didSet {
            // Called when a new value is assigned to dayModels
//            dayModels = dayModels.sorted(by: { $0.title < $1.title })
            dayModels = dayModels.sorted(by: <)
        }
    }
    
    init(title: String, image: UIImage? = nil, dayModels: [DayModel]? = nil) {
        id = UUID().uuidString
        self.title = title
        self.image = image
        
        if let dayModels = dayModels {
            self.dayModels = dayModels
        }
    }
}

