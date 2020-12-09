//
//  TripFunctions.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/4/20.
//

import UIKit

class TripFunctions {
    static func createTrip(tripModel: TripModel) {
        Data.tripModels.append(tripModel)
    }
    
    static func readTrips(completion: @escaping () -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            if Data.tripModels.count == 0 {
                Data.tripModels = MockData.createMockTripModelData()
            }
        }
        DispatchQueue.main.async {
            completion()
        }
    }
    
    static func readTrip(by id: String, completion: @escaping (TripModel?) -> ()) {
        DispatchQueue.global(qos: .userInteractive).async {
            let trip = Data.tripModels.first(where: { return $0.id == id })
            
            DispatchQueue.main.async {
                completion(trip)
            }
        }
    }
    
    static func updateTrip(for index: Int, with title: String, image: UIImage? = nil) {
        let oldTripModel = Data.tripModels[index]
        Data.tripModels[index] = TripModel(title: title, image: image, dayModels: oldTripModel.dayModels)
    }
    
    static func deleteTrip(index: Int) {
        Data.tripModels.remove(at: index)
    }
}
