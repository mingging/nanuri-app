//
//  HomeTableViewCell.swift
//  nanuri-app
//
//  Created by minimani on 2021/11/16.
//

import UIKit

class ProductCustomCell: UITableViewCell {
    
    // MARK: - Product Outlet
    
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var currentPeopleLabel: UILabel!
    @IBOutlet weak var totalPeopleLabel: UILabel!
    
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var processPercentageLabel: UILabel!
    
    @IBOutlet weak var dDayLabel: UILabel!
    
    @IBOutlet weak var dDayView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
