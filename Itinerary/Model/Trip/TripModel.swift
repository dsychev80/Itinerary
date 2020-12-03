//
//  TripModel.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/4/20.
//

import Foundation

class TripModel {
    var id: String!
    var title: String!
    
    init(title: String) {
        id = UUID().uuidString
        self.title = title
    }
}
