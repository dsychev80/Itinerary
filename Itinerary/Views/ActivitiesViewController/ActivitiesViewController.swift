//
//  ActivitiesViewController.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/8/20.
//

import UIKit

class ActivitiesViewController: UIViewController {

    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var tripID: String?
    var tripModel: TripModel?
    var headerHeight: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        self.headerHeight = tableView.dequeueReusableCell(withIdentifier: ActivitiesHeaderViewCell.identifier)?.contentView.bounds.height ?? 44
         
        
        if let tripID = self.tripID {
            TripFunctions.readTrip(by: tripID) { [weak self] (model) in
                guard let self = self else { return }
                self.tripModel = model
                
                guard let model = model else { return }
                self.title = model.title
                self.backgroundImageView.image = model.image
                
                self.tableView.reloadData()
            }
        }
        
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UITableViewDataSource functions
extension ActivitiesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return tripModel?.dayModels.count ?? 0
    }
    
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        let title = tripModel?.dayModels[section].title
//        let subtitle = tripModel?.dayModels[section].subtitle
//        return "\(title ?? "") - \(subtitle ?? "")"
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let tripModel = self.tripModel else {
            return 0
        }
        return tripModel.dayModels[section].activityModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = self.tripModel?.dayModels[indexPath.section].activityModels[indexPath.row] else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: ActivitieTableViewCell.identifier) as! ActivitieTableViewCell
        cell.setup(with: data)
        
        return cell
    }
}

// MARK: - UITableViewDelegate functions
extension ActivitiesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let cell = tableView.dequeueReusableCell(withIdentifier: ActivitiesHeaderViewCell.identifier) as! ActivitiesHeaderViewCell
        guard let data = tripModel?.dayModels[section] else { return nil }
        cell.setup(with: data)
        return cell.contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.headerHeight
    }
}
