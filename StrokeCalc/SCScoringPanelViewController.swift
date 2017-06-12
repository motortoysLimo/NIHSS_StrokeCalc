//
//  SCScoringPanelViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 10/28/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCScoringPanelViewController: UIViewController {

    var scoreTable  = [String:Any]()
    let scoreService = SSCTestScoreService()
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        var totalScore = 0
        for qType in SCQType.allTypes {
            totalScore += scoreService.getScoreAsIntForQuestionNumberAsString(questionNumber: qType.rawValue)
        }
        
        self.scoreLabel.text = "\(totalScore)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openMenu(_ sender: AnyObject) {
        
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
