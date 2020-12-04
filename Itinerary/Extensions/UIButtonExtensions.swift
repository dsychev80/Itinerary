//
//  UIButtonExtensions.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/5/20.
//

import UIKit

 extension UIButton {
    func floatActionButtonStyle() {
        self.backgroundColor = Theme.tint
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.shadowOpacity = 0.25
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = .init(width: 0, height: 10)
    }
}
