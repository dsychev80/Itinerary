//
//  PopupUIView.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/5/20.
//

import UIKit

class PopupUIView: UIView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.addShadowAndRoundedCorners()     
        backgroundColor = Theme.backgroundColor
    }
}
