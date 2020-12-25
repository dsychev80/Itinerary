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
    var tripModel: TripModel! // Needed for saving
    var doneSaving: ((Int, ActivityModel)->())? // Needed for showing days in picker view
    
    // For editing Activities
    var dayIndexToEdit: Int?
    var activityModelToEdit: ActivityModel!
    var doneUpdating: ((Int, Int, ActivityModel) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleLabel.font = UIFont(name: Theme.mainFontName, size: 24)
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        if let dayIndex = dayIndexToEdit, let activity = activityModelToEdit {
            // Update Activity: Populate the popup
            titleLabel.text = "Edit Activity"
            
            // Select the Day in the Picker View
            pickerView.selectRow(dayIndex, inComponent: 0, animated: true)
            
            // Populate the Activity Data
            // TODO: Set the Activity Type Button
            activityTypeSelected(activityTypeButtons[activity.activityType.rawValue])
            titleTextField.text = activity.title
            subtitleTextField.text = activity.subtitle
        } else {
            // New Activity: Set default values
            activityTypeSelected(activityTypeButtons[ActivityType.excursion.rawValue])
        }
    }
    
    @IBAction func activityTypeSelected(_ sender: UIButton) {
        activityTypeButtons.forEach{ $0.tintColor = Theme.accent }
        sender.tintColor = Theme.tintColor
    }
    
    @IBAction func save(_ sender: UIButton) {
        guard titleTextField.hasValue, let newTitle = titleTextField.text else { return }
        let activityType = getActivityType()
        
        let newDayIndex = pickerView.selectedRow(inComponent: 0)
        
        if activityModelToEdit != nil {
            // Update Activity
            activityModelToEdit.title = newTitle
            activityModelToEdit.activityType = activityType
            activityModelToEdit.subtitle = subtitleTextField.text ?? ""
            
            ActivityFunctions.updateActivity(at: tripIndex, with: dayIndexToEdit!, and: newDayIndex, using: activityModelToEdit)
            
            if let doneUpdating = doneUpdating, let oldDayIndex = dayIndexToEdit {
                doneUpdating(oldDayIndex, newDayIndex, activityModelToEdit)
            }
        } else {
            // New Activity
            let activityModel = ActivityModel(title: newTitle, subtitle: subtitleTextField.text ?? "", activityType: activityType)
            ActivityFunctions.createActivity(at: tripIndex, for: newDayIndex, using: activityModel)
            
            if let doneSaving = doneSaving {
                doneSaving(newDayIndex, activityModel)
            }
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
