//
//  SCLoginViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 12/14/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCLoginViewController: UIViewController {
    @IBOutlet weak var validationLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        self.validationLabel.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginAction(_ sender: Any) {
        self.performSegue(withIdentifier: "loginsegue", sender: self)
    }

}
