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

        titleLabel.font = UIFont(name: Theme.mainFontName, size: 24)        
    }


    @IBAction func cancel(_ sender: UIButton) {
        if tripIndexToEdit != nil {
            tripIndexToEdit = nil
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        
        guard titleTextField.hasValue, let title = titleTextField.text else {
            return
        }
        dismiss(animated: true, completion: nil)
    }
}
