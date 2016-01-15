//
//  StatisticsTableViewCell.swift
//  
//
//  Created by Luciano Wehrli on 13/1/16.
//
//

import UIKit

class StatisticsTableViewCell: UITableViewCell {

    @IBOutlet weak var completeDate: UILabel!
    @IBOutlet weak var monthName: UILabel!
    @IBOutlet weak var accumulatedBalance: UILabel!
    @IBOutlet weak var currency: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
