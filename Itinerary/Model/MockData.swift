//
//  MockData.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/9/20.
//

import Foundation
import UIKit

class MockData {
    static func createMockTripModelData() -> [TripModel] {
        var mockData = [TripModel]()
        mockData.append(TripModel(title: "Trip to Bali!", image: UIImage(named: "somePhoto"), dayModels: createDayModelData()))
        mockData.append(TripModel(title: "Mexico", image: nil))
        mockData.append(TripModel(title: "Russian Trip"))

        return mockData
    }
    
    static func createDayModelData() -> [DayModel]? {
        var dayModels = [DayModel]()
        
        dayModels.append(DayModel(title: Date(), subtitle: "Departure", data: createMockActivityData(sectionTitle: "April 18")))
        dayModels.append(DayModel(title: Date().add(days: 1), subtitle: "Exploring", data: createMockActivityData(sectionTitle: "April 19")))
        dayModels.append(DayModel(title: Date().add(days: 2), subtitle: "Scuba Diving", data: createMockActivityData(sectionTitle: "April 20")))
        dayModels.append(DayModel(title: Date().add(days: 3), subtitle: "Volunteering", data: createMockActivityData(sectionTitle: "April 21")))
        dayModels.append(DayModel(title: Date().add(days: 4), subtitle: "Time to go home", data: createMockActivityData(sectionTitle: "April 22")))
        
        return dayModels
    }
    
    static func createMockActivityData(sectionTitle: String) -> [ActivityModel]? {
        var activities = [ActivityModel]()
        
        switch sectionTitle {
        case "April 18":
            activities.append(ActivityModel(title: "SLC", subtitle: "12:25 - 13:45", activityType: .flight))
            activities.append(ActivityModel(title: "LAX", subtitle: "17:30 - 11:00", activityType: .flight))
        case "April 19":
            activities.append(ActivityModel(title: "DPS", subtitle: "11:30 - 13:00", activityType: .flight))
            activities.append(ActivityModel(title: "Bintang Kuta Hotel Checkin", subtitle: "Confirmation: 23lkj4h", activityType: .hotel))
            activities.append(ActivityModel(title: "Pick up rental", subtitle: "Confirmation: 8348993", activityType: .auto))
            activities.append(ActivityModel(title: "Island Excursion", subtitle: "Touring the island", activityType: .excursion))
            activities.append(ActivityModel(title: "Dinner", subtitle: "At Warung Sanur Segar", activityType: .food))
        case "April 20":
            activities.append(ActivityModel(title: "Scuba Diving", subtitle: "Cheking out the Reefs", activityType: .excursion))
            activities.append(ActivityModel(title: "Dinner", subtitle: "At Malaika Secret Moksha", activityType: .food))
        case "April 21":
            activities.append(ActivityModel(title: "Travel", subtitle: "To Nusa Penida", activityType: .flight))
            activities.append(ActivityModel(title: "Volunteering", subtitle: "", activityType: .auto))
            activities.append(ActivityModel(title: "Dinner", subtitle: "At Djunga Bunga", activityType: .food))
            activities.append(ActivityModel(title: "Travel", subtitle: "To Casamontra", activityType: .excursion))
        case "April 22":
            activities.append(ActivityModel(title: "Hotel Checkout", subtitle: "", activityType: .hotel))
            activities.append(ActivityModel(title: "DPS", subtitle: "13:40 - 16:20", activityType: .flight))
            activities.append(ActivityModel(title: "LAX", subtitle: "17:30 - 11:00", activityType: .flight))
            activities.append(ActivityModel(title: "SLC", subtitle: "12:25 - 13:45", activityType: .flight))
        default: break
        }

        return activities
    }
}
