//
//  ActivitieTableViewCell.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/10/20.
//

import UIKit

class ActivitieTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var activityImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cardView.addShadowAndRoundedCorners()
    }
    
    func setup(with data: ActivityModel) {
        titleLabel.font = UIFont(name: Theme.bodyFontNameDemiBold, size: 17)
        subtitleLabel.font = UIFont(name: Theme.bodyFontName, size: 17)
        self.titleLabel.text = data.title
        self.subtitleLabel.text = data.subtitle
        activityImageView.image = getActivityImageView(type: data.activityType)
    }
    
    func getActivityImageView(type: ActivityType) -> UIImage {
        switch type {
        case .auto:
            return #imageLiteral(resourceName: "car")
        case .flight:
            return #imageLiteral(resourceName: "flight")
        case .excursion:
            return #imageLiteral(resourceName: "excurtion")
        case .food:
            return #imageLiteral(resourceName: "food")
        case .hotel:
            return #imageLiteral(resourceName: "hotel")
        }
    }
}
