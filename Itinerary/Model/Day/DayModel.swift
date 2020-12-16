//
//  DayModel.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/9/20.
//

import Foundation

struct DayModel {
    let id: String
    var title: String
    var subtitle: String?
    var activityModels = [ActivityModel]()
    
    init(title: String, subtitle: String?, data: [ActivityModel]?) {
        self.id = UUID().uuidString
        self.title = title
        self.subtitle = subtitle
        
        if let data = data {
            self.activityModels = data
        }
    }
}
