//
//  AddDayViewController.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/12/20.
//

import UIKit

class AddDayViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var doneSaving: ((DayModel) -> ())?
    var tripIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.font = UIFont(name: Theme.mainFontName, size: 24)        
    }

    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        let day = DayModel(title: datePicker.date, subtitle: descriptionTextField.text, data: nil)
        DayFunctions.createDay(with: day, at: tripIndex)
        guard let doneSaving = doneSaving else { return }
        doneSaving(day)
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
}
