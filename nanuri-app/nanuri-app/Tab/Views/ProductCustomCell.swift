//
//  HomeTableViewCell.swift
//  nanuri-app
//
//  Created by minimani on 2021/11/16.
//

import UIKit

class ProductCustomCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var currentPeople: UILabel!
    @IBOutlet weak var totalPeople: UILabel!
    
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var endDate: UILabel!
    
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var processPercentage: UILabel!
    
    @IBOutlet weak var dDay: UILabel!
    
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
