//
//  SCRoundButton.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 11/30/16.
//  Copyright © 2016 Mobile Guru. All rights reserved.
//

import UIKit

class SCRoundButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.shadowOpacity = 0.65
        self.layer.shadowOffset = CGSize(width: -1.0, height: 1)
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 2.0
    }
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                self.layer.shadowOpacity = 0.0
                self.layer.shadowOffset = CGSize(width: 0.0, height: 0)
                self.layer.shadowColor = UIColor.clear.cgColor
                self.layer.shadowRadius = 0.0
            } else {
                self.layer.shadowOpacity = 0.65
                self.layer.shadowOffset = CGSize(width: -1.0, height: 1)
                self.layer.shadowColor = UIColor.black.cgColor
                self.layer.shadowRadius = 2.0
            }
        }
    }
}
