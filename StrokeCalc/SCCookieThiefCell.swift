
//
//  SCCookieThiefCell.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 06/03/2017.
//  Copyright © 2017 Mobile Guru. All rights reserved.
//

import UIKit

class SCCookieThiefCell: UITableViewCell {
    
    // MARK: - Properties
    
    @IBOutlet weak var switchB: UISwitch!
    @IBOutlet weak var contentLabel: UILabel!    
    
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
