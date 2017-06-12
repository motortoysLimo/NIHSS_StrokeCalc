//
//  SCChooseEnvironmentViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 10/20/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCChooseEnvironmentViewController: UIViewController {

    @IBOutlet weak var preHospitalButton: UIButton!
    @IBOutlet weak var hospitalButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.hospitalButton.setBackgroundColor(color: UIColor.init(red: 228, green: 245, blue: 255, transperancy: 1.0), forState: .highlighted )
//        self.preHospitalButton.setBackgroundColor(color: UIColor.init(red: 228, green: 245, blue: 255, transperancy: 1.0), forState: .highlighted )
//        self.hospitalButton.setTitleColor(UIColor.init(red: 27, green: 137, blue: 205, transperancy: 1.0), for: .highlighted)
//        self.preHospitalButton.setTitleColor(UIColor.init(red: 27, green: 137, blue: 205, transperancy: 1.0), for: .highlighted)
//        self.hospitalButton.title
        self.navigationItem.hidesBackButton = true
        self.navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
    }


    // MARK: - Navigation

    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }
    
    @IBAction func openPreHospital(_ sender: AnyObject) {
        performSegue(withIdentifier: "envirnonmentprehospital", sender: self)
    }
    
    @IBAction func openHospital(_ sender: AnyObject) {
        performSegue(withIdentifier: "envirnonmenthospital", sender: self)
    }

}
