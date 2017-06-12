//
//  SCEnvironmentPreHospitalViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 10/20/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCEnvironmentPreHospitalViewController: UIViewController {
    
    @IBOutlet weak var reTestButton: UIButton!
    @IBOutlet weak var initialTestButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.reTestButton.setBackgroundColor(color: UIColor.init(red: 208, green: 225, blue: 236, transperancy: 1.0), forState: .highlighted)
        self.initialTestButton.setBackgroundColor(color: UIColor.init(red: 208, green: 225, blue: 236, transperancy: 1.0), forState: .highlighted)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func initialTest(_ sender: AnyObject) {
        performSegue(withIdentifier: "patientinfoprehospital", sender: self)
    }
    
    @IBAction func retest(_ sender: AnyObject) {
        performSegue(withIdentifier: "patientinfoprehospital", sender: self)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
