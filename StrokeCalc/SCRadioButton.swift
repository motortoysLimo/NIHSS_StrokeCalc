//
//  SCRadioButton.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 1/30/17.
//  Copyright © 2017 Mobile Guru. All rights reserved.
//

import UIKit

class SCRadioButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override var isHighlighted: Bool {
        didSet {
            if (self.isSelected) {
                self.isSelected = false
            } else {
                self.isSelected = true
            }
           
            }
    }

}
