//
//  AppUIButton.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/5/20.
//

import UIKit

class AppUIButton: UIButton {
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.backgroundColor = Theme.tintColor
        self.layer.cornerRadius = self.frame.height / 2
        setTitleColor(UIColor.white, for: .normal)
    }
}
