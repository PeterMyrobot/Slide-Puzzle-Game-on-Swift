//
//  leaderboardTableViewCell.swift
//  SlidePuzzleII
//
//  Created by apple on 18/07/2016.
//  Copyright © 2016 Peter. All rights reserved.
//

import UIKit

class leaderboardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stepLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
