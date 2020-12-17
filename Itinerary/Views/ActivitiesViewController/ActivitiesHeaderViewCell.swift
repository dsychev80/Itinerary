//
//  ActivitiesHeaderViewCell.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/10/20.
//

import UIKit

class ActivitiesHeaderViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        titleLabel.font = UIFont(name: Theme.bodyFontNameBold, size: 17)
        subtitleLabel.font = UIFont(name: Theme.bodyFontName, size: 15)
    }
    
    func setup(with data: DayModel) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        titleLabel.text = dateFormatter.string(from: data.title)
        subtitleLabel.text = data.subtitle
    }
}
