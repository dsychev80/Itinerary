//
//  PXAlertController.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/12/20.
//

import UIKit

class PXAlertController: UIAlertController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for subview in self.view.subviews {
            for constraint in subview.constraints {
                if constraint.firstAttribute == .width && constraint.constant == -16 {
                    constraint.constant = 10
                }
            }
        }
    }
}


