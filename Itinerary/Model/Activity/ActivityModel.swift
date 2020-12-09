//
//  ActivityModel.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/9/20.
//

import Foundation
import UIKit

struct ActivityModel {
    let id: String
    var title: String
    var subtitle: String
    var activityType: ActivityType
    var photo: UIImage?
    
    init(title: String, subtitle: String, activityType: ActivityType, photo: UIImage? = nil) {
        self.id = UUID().uuidString
        self.title = title
        self.subtitle = subtitle
        self.activityType = activityType
        self.photo = photo
    }
}
