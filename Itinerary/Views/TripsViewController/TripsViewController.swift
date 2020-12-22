//
//  TripsViewController.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/4/20.
//

import UIKit

class TripsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet var helpView: UIVisualEffectView!
    @IBOutlet weak var logoView: UIImageView!
    
    let seenHelpView = "seenTripHelp"
    
    var tripIndexToEdit: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        tableView.backgroundColor = .clear
        view.backgroundColor = Theme.backgroundColor
        
        addButton.floatActionButtonStyle()
        
        let radius = CGFloat(200 * Double.pi / 180)
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseIn, animations: {
            self.logoView.alpha = 0
            self.logoView.transform = CGAffineTransform(rotationAngle: radius).scaledBy(x: 3, y: 3)
            let yRotation = CATransform3DMakeRotation(radius, 0, radius, 0)
            self.logoView.layer.transform = CATransform3DConcat(self.logoView.layer.transform, yRotation)
        }) { (success) in
                self.getTripData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddTripSegue" {
            guard let destinationVC = segue.destination as? AddTripViewController else {
                return
            }
            destinationVC.tripIndexToEdit = self.tripIndexToEdit
            destinationVC.doneSaving = { [weak self] in
                guard let self = self else { return }
                self.tableView.reloadData()
            }
            tripIndexToEdit = nil
        }
    }
    
    @IBAction func closeHelpView(_ sender: AppUIButton) {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.helpView.alpha = 0
        } completion: { [weak self] (success) in
            self?.helpView.removeFromSuperview()
            UserDefaults.standard.setValue(true, forKey: (self?.seenHelpView)!)
        }
    }
    
    fileprivate func getTripData() {
        TripFunctions.readTrips { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
            if Data.tripModels.count > 0 {
                if UserDefaults.standard.bool(forKey: self.seenHelpView) == false {
                    self.view.addSubview(self.helpView)
                    self.helpView.frame = self.view.bounds
                }
            }
        }
    }
}

// MARK: - Data Source
extension TripsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.tripModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataTrip = Data.tripModels[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: TripTableViewCell.identifier) as! TripTableViewCell
        cell.setup(with: dataTrip)
        return cell
    }
}

// MARK: - Delegate
extension TripsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (contextualAction, view, actionPerformed: @escaping (Bool) -> ()) in
            
            let alert = UIAlertController(title: "Delete Trip", message: "Are you sure you want to delete this trip?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in
                actionPerformed(false)
            }))
            
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (alertAction) in
                TripFunctions.deleteTrip(index: indexPath.row)
                actionPerformed(true)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }))
            
            self?.present(alert, animated: true, completion: nil)
        }
        delete.image = #imageLiteral(resourceName: "delete")
        delete.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, actionPerform: @escaping (Bool) -> ()) in
            self.tripIndexToEdit = indexPath.row
            self.performSegue(withIdentifier: "toAddTripSegue", sender: nil)
            actionPerform(true)
        }
        editAction.backgroundColor = .systemBlue 
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let trip = Data.tripModels[indexPath.row]
        
        let vc = ActivitiesViewController.getInstance() as! ActivitiesViewController
        vc.tripID = trip.id
        vc.tripTitle = trip.title
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
