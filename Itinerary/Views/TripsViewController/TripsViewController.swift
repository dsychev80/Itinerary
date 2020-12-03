//
//  TripsViewController.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/4/20.
//

import UIKit

class TripsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        
        TripFunctions.readTrips { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension TripsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.tripModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dataTrip = Data.tripModels[indexPath.row]
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = dataTrip.title
        return cell!
    }
    
    
}
