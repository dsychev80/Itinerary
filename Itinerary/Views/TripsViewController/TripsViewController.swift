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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self 
        
        TripFunctions.readTrips { [weak self] in
            self?.tableView.reloadData()
        }
        
        tableView.backgroundColor = .clear
        view.backgroundColor = Theme.backgroundColor
        
        addButton.floatActionButtonStyle()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddTripSegue" {
            guard let destinationVC = segue.destination as? AddTripViewController else {
                return
            }
            destinationVC.doneSaving = { [weak self] in
                guard let self = self else { return }
                self.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TripTableViewCell
        cell.setup(with: dataTrip)
        return cell
    }
}

// MARK: - Delegate
extension TripsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
}
