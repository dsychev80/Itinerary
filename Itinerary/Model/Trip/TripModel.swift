//
//  TripModel.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/4/20.
//

import Foundation

class TripModel {
    let id: UUID
    var title: String
    
    init(title: String) {
        id = UUID()
        self.title = title
    }
}
