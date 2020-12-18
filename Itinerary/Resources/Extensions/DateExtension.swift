//
//  DateExtension.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/16/20.
//

import Foundation

extension Date {
    func add(days: Int) -> Date {
        return Calendar.current.date(byAdding: .day, value: days, to: Date())!
    }
    
    func mediumDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: self)
    }
}
