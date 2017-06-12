//
//  SCPasswordRecoveryViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 12/14/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCPasswordRecoveryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func sendAction(_ sender: Any) {
        self.performSegue(withIdentifier: "linksegue", sender: self)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}
