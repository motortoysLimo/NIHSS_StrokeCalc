//
//  SCQ9RecognitionViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 11/3/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ9RecognitionViewController: SCBaseViewController, SCAlertServiceProtocol {
    
    internal func okButtonPressed() {
        
    }

    // MARK: - Properties
    
    var images = [UIImage]()
    var imageCounter: NSInteger = 0
    var sideScore: NSInteger = 0
    
    @IBOutlet weak var imageToRecognize: UIImageView!
    
    @IBOutlet weak var yesButton: SCAnswerButton!
    @IBOutlet weak var noButton: SCAnswerButton!
    @IBOutlet weak var yesButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var noButtonHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.images = [#imageLiteral(resourceName: "glove"), #imageLiteral(resourceName: "doorkey"), #imageLiteral(resourceName: "cactus"), #imageLiteral(resourceName: "chair"), #imageLiteral(resourceName: "feather"), #imageLiteral(resourceName: "hammack")]
        
        // layout
        self.yesButtonHeightConstraint.constant = SCUtils.shared.sizeFor(value: 65)
        self.noButtonHeightConstraint.constant = SCUtils.shared.sizeFor(value: 65)
        self.yesButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "YES", size: 20), for: UIControlState.normal)
        self.noButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "NO", size: 20), for: UIControlState.normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.presentRotateAlert()
    }
    
    func presentGloveAlert(message: NSMutableAttributedString) {
        
        let alertController = self.storyboard?.instantiateViewController(withIdentifier: "alertcontroller") as! SCAlertViewController
        
        alertController.alertWith(message: message, yesButtonTitle: NSMutableAttributedString().blueButton(text: "YES", size: 20), noButtonTitle: NSMutableAttributedString().blueButton(text: "NO", size: 20))
        alertController.delegate = self
        alertController.alertIdentifier = AlertStyle.gloveA
        alertController.modalTransitionStyle = .crossDissolve
        alertController.modalPresentationStyle = .overCurrentContext
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func presentRotateAlert() {
        
        let alertController = self.storyboard?.instantiateViewController(withIdentifier: "alertcontroller") as! SCAlertViewController
        
        alertController.alertWith(title: NSMutableAttributedString().bold23(text: "", alignment: NSTextAlignment.center), message: NSMutableAttributedString().orangeBold(text: "Please turn the iPhone around and show the next six (6) screens to the patient."), okButtonTitle: NSMutableAttributedString().blueButton(text: "Got it!", size: 20), isLogo: false)
        alertController.delegate = self
        alertController.alertIdentifier = AlertStyle.rotateA
        alertController.modalTransitionStyle = .crossDissolve
        alertController.modalPresentationStyle = .overCurrentContext
        self.present(alertController, animated: true, completion: nil)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - UIButton Actions
    
    @IBAction func noAction(_ sender: Any) {
        if self.imageCounter == 1 { // Glove
            self.presentGloveAlert(message: NSMutableAttributedString().normalBlue(text: "Did the patient respond with the word ").boldBlue(text: "GLOVE").normalBlue(text: " or ").boldBlue(text: "HAND").normalBlue(text: "?"))
            
        } else if self.imageCounter == 3 { // Cactus
            self.presentGloveAlert(message: NSMutableAttributedString().normalBlue(text: "Did the patient respond with the word ").boldBlue(text: "CACTUS").normalBlue(text: " or ").boldBlue(text: "CARTOON ANIMALS").normalBlue(text: "?"))
            
        } else if self.imageCounter == 4 { // Chair
            self.presentGloveAlert(message: NSMutableAttributedString().normalBlue(text: "Did the patient respond with the word ").boldBlue(text: "CHAIR").normalBlue(text: " or ").boldBlue(text: "THRONE").normalBlue(text: "?"))
            
        } else if self.imageCounter == 5 { // Feather
            self.presentGloveAlert(message: NSMutableAttributedString().normalBlue(text: "Did the patient respond with the word ").boldBlue(text: "FEATHER").normalBlue(text: " or ").boldBlue(text: "LEAF").normalBlue(text: "?"))
            
        } else if self.imageCounter == 6 { // Hammock
            self.presentGloveAlert(message: NSMutableAttributedString().normalBlue(text: "Did the patient respond with the word ").boldBlue(text: "HAMMOCK").normalBlue(text: " or ").boldBlue(text: "SWING").normalBlue(text: "?").normalBlue(text: "\n\n*Hammocks are uncommon outside of the Americas. Do not mark down if patient from another culture does not identify it.", size: SCUtils.shared.sizeFor(value: 14)))
            
        } else {
            self.nextImage(index: self.imageCounter)
        }
        
    }
    
    @IBAction func yesAction(_ sender: Any) {
        self.sideScore += 1
        self.nextImage(index: self.imageCounter)
    }
    
    // MARK: - Custom Methods
    
    func nextImage(index: NSInteger) {
        if index <= (self.images.count - 1) {
            self.imageToRecognize.image = self.images[index]
            self.imageCounter = index + 1
        } else {
            self.nextPerform()
        }
    }
    
    func nextPerform() {
        if self.sideScore == 3 || self.sideScore == 4 || self.sideScore == 5 { //
            
            // Show Q9-27A View
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ9_27AViewController") as! SCQ9_27AViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
            
        }else {
            var score = 0
            if self.sideScore == 1 || self.sideScore == 2 { // 2 points
                score = 2
            }else if self.sideScore == 0 { // 3 points
                score = 3
            }else if self.sideScore == 6 { // 0 points
                score = 0
            }
            
            testScoreService.setScoresForQuestions(dictionary: [SCQ9Type.Q9A.rawValue: score])
            
            // Show Q9-28A View
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ9ReadingViewController") as! SCQ9ReadingViewController
            
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    //MARK: - SCAlertServiceProtocol
    
    func yesButtonPressed() {
        self.sideScore += 1
        self.nextImage(index: self.imageCounter)
    }
    
    func noButtonPressed() {
        self.nextImage(index: self.imageCounter)
    }

    func okButtonPressed(sender: UIButton) {
        self.nextImage(index: 0)
    }
}
