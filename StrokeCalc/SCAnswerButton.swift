//
//  SCAnswerButton.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 11/24/16.
//  Copyright © 2016 Mobile Guru. All rights reserved.
//

import UIKit

class SCAnswerButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setBackgroundColor(color: UIColor.init(red: 208, green: 225, blue: 236, transperancy: 1.0), forState: .highlighted)
        self.setBackgroundColor(color: UIColor.init(red: 241, green: 250, blue: 255, transperancy: 1.0), forState: .normal)
        self.setTitleColor(UIColor.init(red: 27, green: 137, blue: 205, transperancy: 1.0), for: .normal)
        self.setTitleColor(UIColor.init(red: 27, green: 137, blue: 205, transperancy: 1.0), for: .highlighted)
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 1))
        lineView.backgroundColor = UIColor.prnCellHighlightedColor
        self.addSubview(lineView)
    }

}
