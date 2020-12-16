//
//  DayFunctions.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/15/20.
//

import Foundation

class DayFunctions {
    
    static func createDay(with data: DayModel, at index: Int) {
        // Replace with real data store code
        
        Data.tripModels[index].dayModels.append(data)
    }
}
