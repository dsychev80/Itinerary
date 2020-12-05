//
//  TripTableViewCell.swift
//  Itinerary
//
//  Created by Denis Sychev on 12/4/20.
//

import UIKit

class TripTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var tripImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cardView.addShadowAndRoundedCorners()
        titleLable.font = UIFont(name: Theme.mainFontName, size: 32)
        cardView.backgroundColor = Theme.accent
        self.backgroundColor = .clear
        self.tripImageView.layer.cornerRadius = cardView.layer.cornerRadius
    }
    
    func setup(with tripModel: TripModel) {
        self.titleLable.text = tripModel.title
        self.tripImageView.image = tripModel.image
    }
}
