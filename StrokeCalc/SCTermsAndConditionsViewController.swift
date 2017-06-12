//
//  SCTermsAndConditionsViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 10/25/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCTermsAndConditionsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dissmissTerms(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func sendTerms(_ sender: AnyObject) {
        dismiss(animated: true, completion: nil)
    }
}
