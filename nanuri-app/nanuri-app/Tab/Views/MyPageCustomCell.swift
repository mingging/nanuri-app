//
//  MyPageCustomCell.swift
//  nanuri-app
//
//  Created by a0000 on 2021/11/29.
//

import UIKit

class MyPageCustomCell: UITableViewCell {
  
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var currentPeopleLabel: UILabel!
    @IBOutlet weak var totalPeopleLabel: UILabel!
    
    
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet weak var processPercentageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
