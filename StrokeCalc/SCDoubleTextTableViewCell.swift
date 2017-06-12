//
//  SCDoubleTextTableViewCell.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 12/11/16.
//  Copyright © 2016 Mobile Guru. All rights reserved.
//

import UIKit

class SCDoubleTextTableViewCell: UITableViewCell {
    @IBOutlet weak var titleText: UILabel!

    @IBOutlet weak var subtitleText: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
