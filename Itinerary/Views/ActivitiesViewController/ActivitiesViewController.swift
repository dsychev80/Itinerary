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
        let addActivitieAction = UIAlertAction(title: "Activity", style: .default, handler: handleAddActivity)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            
        }
        
        addActivitieAction.isEnabled = tripModel!.dayModels.count > 0
        
        alertController.addAction(addDayAction)
        alertController.addAction(addActivitieAction)
        alertController.addAction(cancelAction)
        
        alertController.view.tintColor = Theme.tintColor 
        
        present(alertController, animated: true, completion: nil)
    }
    
    fileprivate func getTripIndex() -> Array<TripModel>.Index! {
        return Data.tripModels.firstIndex(where: { (tripModel) -> Bool in
            tripModel.id == self.tripID
        })
    }
    
    @IBAction func toggleEditMode(_ sender: UIBarButtonItem) {
//        tableView.isEditing = !tableView.isEditing
        tableView.isEditing.toggle()
        sender.title = sender.title == "Edit" ? "Done" : "Edit"
    }
    
    func handleAddDay(action: UIAlertAction) {
        let vc = AddDayViewController.getInstance() as! AddDayViewController
        vc.tripIndex = getTripIndex()
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
    
    func handleAddActivity(action: UIAlertAction) {
        let vc = AddActivityViewController.getInstance() as! AddActivityViewController
        vc.tripModel = self.tripModel
        vc.tripIndex = getTripIndex()
        vc.doneSaving = { [weak self] (dayIndex, activity) in
            guard let self = self else { return }
            self.tripModel?.dayModels[dayIndex].activityModels.append(activity)
            let row = (self.tripModel?.dayModels[dayIndex].activityModels.count)! - 1
            let indexPath = IndexPath(row: row, section: dayIndex)
            self.tableView.insertRows(at: [indexPath], with: .automatic)
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
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let activity = tripModel?.dayModels[indexPath.section].activityModels[indexPath.row]
        
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, actionPerformed: @escaping (Bool) -> Void) in
            let alert = UIAlertController(title: "Delete Activity", message: "Are you sure you want to delete this activity: \(activity!.title)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in
                actionPerformed(false)
            }))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (alertAction) in
                ActivityFunctions.deleteActivity(at: self.getTripIndex(), for: indexPath.section, using: activity!)
                self.tripModel?.dayModels[indexPath.section].activityModels.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                actionPerformed(true)
            }))
            self.present(alert, animated: true, completion: nil)
        }
        
        delete.image = #imageLiteral(resourceName: "delete")
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = UIContextualAction(style: .normal, title: "Edit") { (contextualAction, view, actionPerformed: (Bool) -> ()) in
            let vc = AddActivityViewController.getInstance() as! AddActivityViewController
            
            // Which trip are we on
            vc.tripModel = self.tripModel
            
            // Which trip are we working with?
            vc.tripIndex = self.getTripIndex()
            
            // Which Day are we on?
            vc.dayIndexToEdit = indexPath.section
            
            // Which Activity are we editing?
            vc.activityModelToEdit = self.tripModel?.dayModels[indexPath.section].activityModels[indexPath.row]
            
            // What do we want to happen after the Activity is saved?
            vc.doneUpdating = { [weak self] oldDayIndex, newDayIndex, activityModel in
                guard let self = self else { return }
                
                let oldActivityIndex = (self.tripModel?.dayModels[oldDayIndex].activityModels.firstIndex(of: activityModel))!
                
                if oldDayIndex == newDayIndex {
                    // Update the local table data
                    self.tripModel?.dayModels[newDayIndex].activityModels[oldActivityIndex] = activityModel
                    // Refresh just that row
                    let indexPath = IndexPath(row: oldActivityIndex, section: newDayIndex)
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                } else {
                    // Activity moved to a different day
                    
                    // Remove activity from local table data
                    self.tripModel?.dayModels[oldDayIndex].activityModels.remove(at: oldActivityIndex)
                    // Insert activity into new location
                    let lastIndex = (self.tripModel?.dayModels[newDayIndex].activityModels.count)!
                    self.tripModel?.dayModels[newDayIndex].activityModels.insert(activityModel, at: lastIndex)
                    // Update table rows
                    tableView.performBatchUpdates({
                        tableView.deleteRows(at: [indexPath], with: .automatic)
                        let insertIndexPath = IndexPath(row: lastIndex, section: newDayIndex)
                        tableView.insertRows(at: [insertIndexPath], with: .automatic)
                    })
                }
            }
            self.present(vc, animated: true, completion: nil)
            actionPerformed(true)
        }
        
        edit.backgroundColor = .systemBlue
        
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        // 1. Get the current Activity
        let activityModel = (tripModel?.dayModels[sourceIndexPath.section].activityModels[sourceIndexPath.row])!
        // 2. Delete activity from old location
        tripModel?.dayModels[sourceIndexPath.section].activityModels.remove(at: sourceIndexPath.row)
        // 3. Insert activity into the new location
        tripModel?.dayModels[destinationIndexPath.section].activityModels.insert(activityModel, at: destinationIndexPath.row)
        // 4. Update the data store
        ActivityFunctions.reoderActivity(at: getTripIndex(), oldDayIndex: sourceIndexPath.section, newDayIndex: destinationIndexPath.section, newActivityIndex: destinationIndexPath.row, using: activityModel)
    }
}
