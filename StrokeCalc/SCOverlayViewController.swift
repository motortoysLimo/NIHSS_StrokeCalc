//
//  SCOverlayViewController.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 11/03/2017.
//  Copyright © 2017 Mobile Guru. All rights reserved.
//

import UIKit

class SCOverlayViewController: UIViewController {
    
    // MARK: - Properties

    @IBOutlet weak var contentLabel: UILabel!
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.contentLabel.font = UIFont(name: self.contentLabel.font.fontName, size: SCUtils.shared.sizeFor(value: 23))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func closeTouchUp(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
