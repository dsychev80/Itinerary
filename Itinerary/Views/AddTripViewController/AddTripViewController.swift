//
//  AddTripViewController.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/5/20.
//

import UIKit
import Photos

class AddTripViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var doneSaving: (() -> ())?
    var tripIndexToEdit: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        titleLabel.font = UIFont(name: Theme.mainFontName, size: 24)
        imageView.layer.cornerRadius = 10
        
        // Do titleLabel shadow lighter to make it more readable on darker images
        titleLabel.layer.shadowColor = UIColor.white.cgColor
        titleLabel.layer.shadowOpacity = 1
        titleLabel.layer.shadowOffset = CGSize.zero
        titleLabel.layer.shadowRadius = 5
        
        if let index = tripIndexToEdit {
            let trip = Data.tripModels[index]
            textField.text = trip.title
            imageView.image = trip.image
            titleLabel.text = "Edit trip"
        }
    }


    @IBAction func cancel(_ sender: UIButton) {
        if tripIndexToEdit != nil {
            tripIndexToEdit = nil
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: UIButton) {
        textField.rightViewMode = .never
        
        guard let title = textField.text, !title.isEmpty, title != "" else {
            self.setupTextFieldValidation()
            return
        }
        let image = imageView.image
        if let index = tripIndexToEdit {
            TripFunctions.updateTrip(for: index, with: title, image: image)
        } else {
            TripFunctions.createTrip(tripModel: TripModel(title: title, image: image))
        }
        
        guard let doneSaving = doneSaving else { return }
        doneSaving()
        dismiss(animated: true, completion: nil)
    }
    
    fileprivate func presentPhotoPickerController() {
        DispatchQueue.main.async { [weak self] in
            let pickerController = UIImagePickerController()
            pickerController.delegate = self
            pickerController.sourceType = .photoLibrary
            self?.present(pickerController, animated: true, completion: nil)
        }
    }
    
    @IBAction func addImage(_ sender: UIButton) {
        PHPhotoLibrary.requestAuthorization { [weak self] (status) in
            switch status {
            case .authorized:
                self?.presentPhotoPickerController()
            case .notDetermined:
                self?.presentPhotoPickerController()
            case .restricted:
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Photo Library Restricted", message: "Photo Library access is restricted and cannot be access.", preferredStyle: .alert)
                    let okButton = UIAlertAction(title: "Ok", style: .default, handler: nil)
                    alert.addAction(okButton)
                    
                    self?.present(alert, animated: true, completion: nil)
                }
            case .denied:
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Photo Library Access Denied", message: "Photo Library access was previously denied. Please update your Settings if you wish to change this.", preferredStyle: .alert)
                    let goToSettings = UIAlertAction(title: "Go to Settings", style: .default, handler: { (action) in
                        DispatchQueue.main.async {
                            if let url = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        }
                    })
                    let cancelButton = UIAlertAction(title: "Cancel", style: .default, handler: nil)
                
                    alert.addAction(goToSettings)
                    alert.addAction(cancelButton)
                    
                    self?.present(alert, animated: true, completion: nil)
                }
            case .limited:
                break
            @unknown default:
                break
            }
        }
    }
    
    fileprivate func setupTextFieldValidation() {
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

// MARK:- UIImagePickerControllerDelegate
extension AddTripViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.imageView.image = image
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}

// MARK: - UINavigationDelegate
extension AddTripViewController: UINavigationControllerDelegate {
    
}


