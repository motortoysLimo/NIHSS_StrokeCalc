//
//  SCEyeTableViewCell.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 09/03/2017.
//  Copyright © 2017 Mobile Guru. All rights reserved.
//

import UIKit

class SCEyeTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var description1: UILabel!
    @IBOutlet weak var description2: UILabel!
    
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    
    // MARK: - Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
