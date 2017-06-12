//
//  SCCenteredLabelTableViewCell.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 11/5/16.
//  Copyright © 2016 Mobile Guru. All rights reserved.
//

import UIKit

class SCCenteredLabelTableViewCell: UITableViewCell {

    @IBOutlet weak var answerLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if (highlighted) {
            self.backgroundColor = UIColor.prnCellHighlightedColor
        }
        else {
            self.backgroundColor = UIColor.prnCellNormalColor
        }
    }

}
