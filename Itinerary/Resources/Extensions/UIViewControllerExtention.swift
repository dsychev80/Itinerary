//
//  UIViewControllerExtention.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/15/20.
//

import UIKit

extension UIViewController {
    
    /**
     Just returns the inital view controller on a storyboard
     */
    static func getInstance() -> UIViewController {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController()!
    }
}
