//
//  SCQ9SentencesViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 11/3/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ9SentencesViewController: SCBaseViewController, SCAlertServiceProtocol {
    
    // MARK: - Properties
    
    @IBOutlet weak var nextButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButton: SCAnswerButton!
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.nextButtonHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
        self.nextButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "NEXT", size: 20), for: UIControlState.normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showInstructionAlert()
    }
    
//    func showInstructionAlert() {
//        let alertController = self.storyboard?.instantiateViewController(withIdentifier: "alertcontroller") as! SCAlertViewController
//        
//        alertController.alertWith(title: NSMutableAttributedString().bold23(text: "", alignment: NSTextAlignment.center), message: NSMutableAttributedString().orangeBold(text: "Please turn the iPhone around and show the screen to the patient."), okButtonTitle: NSMutableAttributedString().blueButton(text: "Got it!", size: 20), isLogo: false)
//        alertController.delegate = self
//        alertController.alertIdentifier = AlertStyle.rotateA
//        alertController.modalTransitionStyle = .crossDissolve
//        alertController.modalPresentationStyle = .overCurrentContext
//        self.present(alertController, animated: true, completion: nil)
//    }
    
    func showInstructionAlert() {
        let alertController = self.storyboard?.instantiateViewController(withIdentifier: "alertcontroller") as! SCAlertViewController
        alertController.alertWith(title: NSMutableAttributedString(string: ""), message: NSMutableAttributedString().orangeBold(text: "Please turn the iPhone around and show the screen to the patient"), okButtonTitle: NSMutableAttributedString().blueButton(text: "Got it!", size: 20), isPhone: true)
        alertController.delegate = self
        alertController.modalTransitionStyle = .crossDissolve
        alertController.modalPresentationStyle = .overCurrentContext
        self.present(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func nextAction(_ sender: Any) {
        self.performSegue(withIdentifier: "toq9readingsentences", sender: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - SCAlertServiceProtocol
    
    func okButtonPressed(sender: UIButton) {
        
    }

}
