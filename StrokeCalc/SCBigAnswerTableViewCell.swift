//
//  SCBigAnswerTableViewCell.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 11/5/16.
//  Copyright © 2016 Mobile Guru. All rights reserved.
//

import UIKit

class SCBigAnswerTableViewCell: UITableViewCell {

    
    @IBOutlet weak var faceImageView: UIImageView!
    @IBOutlet weak var dictButton: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var numberImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
