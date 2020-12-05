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
        textField.rightViewMode = .never
        
        guard let title = textField.text, !title.isEmpty, title != "" else {
            self.setupTextFieldValidation()
            return
        }
        TripFunctions.createTrip(tripModel: TripModel(title: title))
        guard let doneSaving = doneSaving else { return }
        doneSaving()
        dismiss(animated: true, completion: nil)
    }
    
    private func setupTextFieldValidation() {
        let imageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 20, height: 20))
        imageView.image = UIImage(named: "warning.png")
        imageView.contentMode = .scaleAspectFit
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        view.addSubview(imageView)
        
        textField.rightView = view
        textField.rightViewMode = .always
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.cornerRadius = 5
        
        textField.placeholder = "Trip name required!"
    }
}
