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
        
        dayModels.append(DayModel(title: "April 18", subtitle: "Departure", data: createMockActivityData(sectionTitle: "April 18")))
        dayModels.append(DayModel(title: "April 19", subtitle: "Exploring", data: createMockActivityData(sectionTitle: "April 19")))
        dayModels.append(DayModel(title: "April 20", subtitle: "Scuba Diving", data: createMockActivityData(sectionTitle: "April 20")))
        dayModels.append(DayModel(title: "April 21", subtitle: "Volunteering", data: createMockActivityData(sectionTitle: "April 21")))
        dayModels.append(DayModel(title: "April 22", subtitle: "Time to go home", data: createMockActivityData(sectionTitle: "April 22")))
        
        return dayModels
    }
    
    static func createMockActivityData(sectionTitle: String) -> [ActivityModel]? {
        var activities = [ActivityModel]()
        
        switch sectionTitle {
        case "April 18":
            activities.append(ActivityModel(title: "SLC", subtitle: "", activityType: .auto))
            activities.append(ActivityModel(title: "LAX", subtitle: "", activityType: .auto))
        case "April 19":
            activities.append(ActivityModel(title: "DPS", subtitle: "", activityType: .auto))
            activities.append(ActivityModel(title: "Bintang Kuta Hotel Checkin", subtitle: "", activityType: .auto))
            activities.append(ActivityModel(title: "Pick up rental", subtitle: "", activityType: .auto))
            activities.append(ActivityModel(title: "Island Excursion", subtitle: "", activityType: .auto))
            activities.append(ActivityModel(title: "Dinner", subtitle: "", activityType: .auto))
        case "April 20":
            activities.append(ActivityModel(title: "Scuba Diving", subtitle: "", activityType: .auto))
            activities.append(ActivityModel(title: "Dinner", subtitle: "", activityType: .auto))
        case "April 21":
            activities.append(ActivityModel(title: "Travel", subtitle: "", activityType: .auto))
            activities.append(ActivityModel(title: "Volunteering", subtitle: "", activityType: .auto))
            activities.append(ActivityModel(title: "Dinner", subtitle: "", activityType: .auto))
            activities.append(ActivityModel(title: "Travel", subtitle: "", activityType: .auto))
        case "April 22":
            activities.append(ActivityModel(title: "Hotel Checkout", subtitle: "", activityType: .auto))
            activities.append(ActivityModel(title: "DPS", subtitle: "", activityType: .auto))
            activities.append(ActivityModel(title: "LAX", subtitle: "", activityType: .auto))
            activities.append(ActivityModel(title: "SLC", subtitle: "", activityType: .auto))
        default: break
        }

        return activities
    }
}
