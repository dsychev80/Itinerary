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
    @IBOutlet weak var addButton: AppUIButton!
    
    var tripID: String?
    var tripModel: TripModel?
    var tripTitle: String = ""
    var headerHeight: CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = tripTitle
        self.addButton.floatActionButtonStyle()
        
        tableView.dataSource = self
        tableView.delegate = self
        self.headerHeight = tableView.dequeueReusableCell(withIdentifier: ActivitiesHeaderViewCell.identifier)?.contentView.bounds.height ?? 44
         
        updateTableViewWithTripData()
    }
    
    @IBAction func back(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addAction(_ sender: UIButton) {
        let alertController = PXAlertController(title: "Which would you like to add?", message: nil, preferredStyle: .actionSheet)
        let addDayAction = UIAlertAction(title: "Day", style: .default, handler: handleAddDay)
        let addActivitieAction = UIAlertAction(title: "Activity", style: .default) { (action) in
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        alertController.addAction(addDayAction)
        alertController.addAction(addActivitieAction)
        alertController.addAction(cancelAction)
        
        alertController.view.tintColor = Theme.tintColor 
        
        present(alertController, animated: true, completion: nil)
    }
    
    func handleAddDay(action: UIAlertAction) {
        let vc = AddDayViewController.getInstance() as! AddDayViewController
        vc.tripIndex = Data.tripModels.firstIndex(where: { (tripModel) -> Bool in
            tripModel.id == self.tripID
        })
        vc.doneSaving = { [weak self] (day) in
            guard let self = self else { return }
            
//            let indexArray = [self.tripModel?.dayModels.count ?? 0]
            self.tripModel?.dayModels.append(day)
            let indexArray = [self.tripModel?.dayModels.firstIndex(of: day) ?? 0]
            
            self.tableView.insertSections(IndexSet(indexArray), with: .automatic)
//            self.updateTableViewWithTripData()
        }
        present(vc, animated: true, completion: nil)
    }
    
    fileprivate func updateTableViewWithTripData() {
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
