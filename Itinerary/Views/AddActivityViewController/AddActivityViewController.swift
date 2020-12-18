//
//  AddActivityViewController.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/17/20.
//

import UIKit

class AddActivityViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var subtitleTextField: UITextField!
    @IBOutlet var activityTypeButtons: [UIButton]!
    
    var tripIndex: Int!
    var tripModel: TripModel!
    
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
        let activityType = getActivityType()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
