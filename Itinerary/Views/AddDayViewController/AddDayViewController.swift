//
//  AddDayViewController.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/12/20.
//

import UIKit

class AddDayViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var doneSaving: (() -> ())?
    var tripIndexToEdit: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.font = UIFont(name: Theme.mainFontName, size: 24)
        
        // Do titleLabel shadow lighter to make it more readable on darker images
        titleLabel.layer.shadowColor = UIColor.white.cgColor
        titleLabel.layer.shadowOpacity = 1
        titleLabel.layer.shadowOffset = CGSize.zero
        titleLabel.layer.shadowRadius = 5
    }


    @IBAction func cancel(_ sender: UIButton) {
        if tripIndexToEdit != nil {
            tripIndexToEdit = nil
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        titleTextField.rightViewMode = .never
        
        guard let title = titleTextField.text, !title.isEmpty, title != "" else {
            self.setupTextFieldValidation()
            return
        }
        
//        guard let doneSaving = doneSaving else { return }
//        doneSaving() 
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupTextFieldValidation() {
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        imageView.image = UIImage(named: "warning.png")
        imageView.contentMode = .scaleAspectFit
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        view.addSubview(imageView)
        
        titleTextField.rightView = view
        titleTextField.rightViewMode = .always
        titleTextField.layer.borderWidth = 1
        titleTextField.layer.borderColor = UIColor.red.cgColor
        titleTextField.layer.cornerRadius = 5
        
        titleTextField.placeholder = "Trip name required!"
    }

}
