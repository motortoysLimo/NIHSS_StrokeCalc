//
//  SCExtendedCell.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 1/24/17.
//  Copyright © 2017 Mobile Guru. All rights reserved.
//

import UIKit

protocol SCExtendedCellActionProtocol {
    func infoButtonTappedWithTag(tag : Int)
}

class SCExtendedCell: UITableViewCell {

    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!
    
    var infoDelegate : SCExtendedCellActionProtocol?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func actionTapped(_ sender: Any) {
        infoDelegate?.infoButtonTappedWithTag(tag: (sender as! UIButton).tag)
    }
}
