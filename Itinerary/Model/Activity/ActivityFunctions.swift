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
    
    static func deleteActivity(at tripIndex: Int, for dayIndex: Int, using activityModel: ActivityModel) {
        var dayModel = Data.tripModels[tripIndex].dayModels[dayIndex]
        if let index = dayModel.activityModels.firstIndex(of: activityModel) {
            dayModel.activityModels.remove(at: index)
        }
    }
    
    static func updateActivity(at tripIndex: Int, with oldDayIndex: Int, and newDayIndex: Int, using activity: ActivityModel) {
        
        if oldDayIndex != newDayIndex {
            // Move activity to different Day
            let lastIndex = Data.tripModels[tripIndex].dayModels[newDayIndex].activityModels.count
           reoderActivity(at: tripIndex, oldDayIndex: oldDayIndex, newDayIndex: newDayIndex, newActivityIndex: lastIndex, using: activity)
        } else {
            // Update activity in same Day
            let dayModel = Data.tripModels[tripIndex].dayModels[oldDayIndex]
            let activityIndex = (dayModel.activityModels.firstIndex(of: activity))!
            Data.tripModels[tripIndex].dayModels[newDayIndex].activityModels[activityIndex] = activity
        }
    }
    
    static func reoderActivity(at tripIndex: Int, oldDayIndex: Int, newDayIndex: Int, newActivityIndex: Int, using activity: ActivityModel) {
        
        // 1. Remove activity from old location
        let oldDayModel = Data.tripModels[tripIndex].dayModels[oldDayIndex]
        if let oldActivityIndex = oldDayModel.activityModels.firstIndex(of: activity) {
            Data.tripModels[tripIndex].dayModels[oldDayIndex].activityModels.remove(at: oldActivityIndex)
        }
        
        // 2. Insert activity into new location
        Data.tripModels[tripIndex].dayModels[newDayIndex].activityModels.insert(activity, at: newActivityIndex)
    }
}
