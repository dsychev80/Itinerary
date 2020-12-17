//
//  DayModel.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/9/20.
//

import Foundation

struct DayModel {
    let id: String
    var title = Date()
    var subtitle: String?
    var activityModels = [ActivityModel]()
    
    init(title: Date, subtitle: String?, data: [ActivityModel]?) {
        self.id = UUID().uuidString
        self.title = title
        self.subtitle = subtitle
        
        if let data = data {
            self.activityModels = data
        }
    }
}

//MARK: - Comparable
extension DayModel: Comparable {
    static func < (lhs: DayModel, rhs: DayModel) -> Bool {
        return lhs.title < rhs.title
    }
    
    static func == (lhs: DayModel, rhs: DayModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    
}
