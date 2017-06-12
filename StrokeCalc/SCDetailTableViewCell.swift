//
//  SCDetailTableViewCell.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 11/23/16.
//  Copyright © 2016 Mobile Guru. All rights reserved.
//

import UIKit

class SCDetailTableViewCell: UITableViewCell {

 
    
    @IBOutlet weak var glasses: SCRoundButton!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var coachButton: UIButton!
    @IBOutlet weak var mimicButton: UIButton!
    @IBOutlet weak var lightBulbButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var questionInfolabel: UILabel!
    @IBOutlet weak var totalScore: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    
    @IBOutlet weak var videoView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
//        if mimicButton != nil {
//            mimicButton.setShadowLayer()
//        }
//        
//        if lightBulbButton != nil {
//            lightBulbButton.setShadowLayer()
//        }
//        
//        if coachButton != nil {
//            lightBulbButton.setShadowLayer()
//        }
//        
//        if timerButton != nil {
//            lightBulbButton.setShadowLayer()
//        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
