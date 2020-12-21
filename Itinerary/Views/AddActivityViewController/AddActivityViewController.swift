//
//  AddActivityViewController.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/17/20.
//

import UIKit

class AddActivityViewController: UITableViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet var activityTypeButtons: [UIButton]!
    
    var tripIndex: Int!
    var tripModel: TripModel!
    var doneSaving: ((Int, ActivityModel)->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.font = UIFont(name: Theme.mainFontName, size: 24)
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    @IBAction func activityTypeSelected(_ sender: UIButton) {
        activityTypeButtons.forEach{ $0.tintColor = Theme.accent }
        sender.tintColor = Theme.tintColor
    }
    
    @IBAction func save(_ sender: UIButton) {
        guard titleTextField.hasValue, let newTitle = titleTextField.text else { return }
        let activityType = getActivityType()
        let activityModel = ActivityModel(title: newTitle, subtitle: subtitleTextField.text ?? "", activityType: activityType)
        let dayIndex = pickerView.selectedRow(inComponent: 0)
        ActivityFunctions.createActivity(at: tripIndex, for: dayIndex, using: activityModel)
        if let doneSaving = doneSaving {
            doneSaving(dayIndex, activityModel)
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func done(_ sender: UITextField) {
        sender.resignFirstResponder()
    }
    
    func getActivityType() -> ActivityType {
        for (index, button) in activityTypeButtons.enumerated() {
            if button.tintColor == Theme.tintColor {
                return ActivityType(rawValue: index) ?? .excursion
            }
        }
        return .excursion
    }
}

// MARK:- UIPickerViewDataSource
extension AddActivityViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return tripModel.dayModels.count
    }
}

// MARK:- UIPickerViewDelegate
extension AddActivityViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return tripModel.dayModels[row].title.mediumDate()
    }
}
