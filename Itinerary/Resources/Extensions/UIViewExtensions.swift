//
//  UIViewExtensions.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/4/20.
//

import UIKit

extension UIView {
    func addShadowAndRoundedCorners() {
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.cornerRadius = 10
    }
}
