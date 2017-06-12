//
//  SCCameraControlView.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 10/26/16.
//  Copyright © 2016 Mobile Guru. All rights reserved.
//

import UIKit

protocol SCCameraControlViewDelegate {
     func flashTrigerred()
     func photoTaken()
     func close()
     func openPhotos()
}

class SCCameraControlView: UIView {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    var delegate : SCCameraControlViewDelegate?
    
    
    @IBAction func flashTrigger(_ sender: AnyObject) {
        delegate?.flashTrigerred()
    }
    
    @IBAction func takePhoto(_ sender: AnyObject) {
        delegate?.photoTaken()
    }
    
    @IBAction func close(_ sender: AnyObject) {
        delegate?.close()
    }
    
    @IBAction func openPhotos(_ sender: AnyObject) {
        delegate?.openPhotos()
    }
   
    
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}
