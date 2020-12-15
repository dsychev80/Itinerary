//
//  UITextFieldExtension.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/15/20.
//

import UIKit

extension UITextField {
    
    var hasValue: Bool {
        
        guard self.text == "" else { return true }
        
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        imageView.image = UIImage(named: "warning.png")
        imageView.contentMode = .scaleAspectFit
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        view.addSubview(imageView)
        
        self.rightView = view
        self.rightViewMode = .unlessEditing
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.cornerRadius = 5
        
        self.placeholder = "This field required!"
        return false
    }
}
