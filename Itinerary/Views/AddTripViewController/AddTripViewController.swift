//
//  AddTripViewController.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/5/20.
//

import UIKit

class AddTripViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    var doneSaving: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.font = UIFont(name: Theme.mainFontName, size: 24)
        
    }

    @IBAction func cancel(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        guard let title = textField.text, !title.isEmpty else { return }
        TripFunctions.createTrip(tripModel: TripModel(title: title))
        guard let doneSaving = doneSaving else { return }
        doneSaving()
        dismiss(animated: true, completion: nil)
    }
    
}
