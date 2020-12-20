//
//  ActivityFunctions.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/19/20.
//

import Foundation

class ActivityFunctions {
    static func createActivity(at tripIndex: Int, for dayIndex: Int, using activityModel: ActivityModel) {
        Data.tripModels[tripIndex].dayModels[dayIndex].activityModels.append(activityModel)
    }
}
