//
//  SCQ10ReadWordsViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 12/11/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ10ReadWordsViewController: SCBaseViewController, SCAlertServiceProtocol {
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if SCAnswerStatus.sharedInstance.isAdjustForGuardRail6 {
            
            self.presentRotateAlert()
        }else { // Continue for Guardrail 6
            
//            self.presentOverlay()
            self.showInstructionAlert()
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showInstructionAlert() {
        let alertController = self.storyboard?.instantiateViewController(withIdentifier: "alertcontroller") as! SCAlertViewController
        alertController.alertWith(title: NSMutableAttributedString(string: ""), message: NSMutableAttributedString().orangeBold(text: "Please turn the iPhone around and show the screen to the patient"), okButtonTitle: NSMutableAttributedString().blueButton(text: "Got it!", size: 20), isPhone: true)
        alertController.delegate = self
        alertController.modalTransitionStyle = .crossDissolve
        alertController.modalPresentationStyle = .overCurrentContext
        self.present(alertController, animated: true, completion: nil)
    }
    
    func presentOverlay() {
        let overlayVC = self.storyboard?.instantiateViewController(withIdentifier: "SCOverlayViewController") as! SCOverlayViewController
        
        overlayVC.modalTransitionStyle = .crossDissolve
        overlayVC.modalPresentationStyle = .overCurrentContext
        self.present(overlayVC, animated: true, completion: nil)
    }
    

    @IBAction func nextAction(_ sender: Any) {
        if SCAnswerStatus.sharedInstance.isAdjustForGuardRail6 {
            
        }else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ10_40AViewController") as! SCQ10_40AViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - Custom Methods
    
    func presentRotateAlert() {
        let alertController = self.storyboard?.instantiateViewController(withIdentifier: "alertcontroller") as! SCAlertViewController
        alertController.delegate = self
        alertController.alertIdentifier = AlertStyle.rotateA
        alertController.modalTransitionStyle = .crossDissolve
        alertController.modalPresentationStyle = .overCurrentContext
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - SCAlertServiceProtocol
    
    func yesButtonPressed() {
        //
    }
    
    func noButtonPressed() {
        //
    }
    
    func okButtonPressed(sender: UIButton) {
        
    }

}
