//
//  SCQ9ExpressionOfEventViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 11/3/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ9ExpressionOfEventViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource, SCImageViewProtocol {
    
    // MARK: - Properties
    
    @IBOutlet weak var nextButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButton: SCAnswerButton!
    
    @IBOutlet weak var glassButton: SCRoundButton!
    
    // MARK: - Methods

    @IBAction func glassesTapped(_ sender: Any) {
        self.infoImage = #imageLiteral(resourceName: "glasses_icon")
        self.infoDetail = NSMutableAttributedString().normal(text: "Please remind the patient to wear their glasses when you see the icon.")//\n\nIf the patient does not have their glasses or has difficulty with vision, you may tap on this icon for tips to modify the exam to fit the patient's needs.")
        self.performSegue(withIdentifier: "showinfo", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.nextButtonHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
        self.nextButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "NEXT", size: 20), for: UIControlState.normal)
//        self.glassButton.setShadowLayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDelegate / UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if testScoreService.getFlowNumber() == 3 {
            return SCUtils.shared.sizeFor(value: 900)
        }else if testScoreService.getFlowNumber() == 4 {
            return SCUtils.shared.sizeFor(value: 700)
        }
        return SCUtils.shared.sizeFor(value: 870)
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell") as! SCDetailTableViewCell
        
        if testScoreService.getFlowNumber() == 3 {
            cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "9. Best Language -\nExpression of Event\n").normalBlue(text: "and\n").boldHeader(text: "11. Inattention")
            cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "Tap the picture below to show it to the patient (when done, tap again to come back to this screen).")
            cell.contentLabel.attributedText = NSMutableAttributedString().normal(text: "Ask the patient ").orangeBold(text: "TO DESCRIBE EVERYTHING THE PATIENT SEES HAPPENING").normal(text: " in the picture.\nCheck if they notice:\n\n1. On the ").bold(text: "left").normal(text: " side, there is a child\n  stealing from the cookie jar.\n\n2. On the ").bold(text: "right").normal(text: " side, there is a mother washing dishes in an overflowing sink.")
            
        }else if testScoreService.getFlowNumber() == 4 {
            
            cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "9. Best Language -\nFor Intubated Patient\nExpression of Event\n").normalBlue(text: "and\n").boldHeader(text: "11. Inattention")
            cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "Tap the picture below to show it to the patient (when done, tap again to come back to this screen).\n\nAsk the patient ").orangeBold(text: "TO WRITE EVERYTHING THE PATIENT SEES HAPPENING").normal(text: " in the picture.")
            cell.contentLabel.attributedText = NSMutableAttributedString(string: "")
        }
        
            return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    // MARK: - UIButton Action
    
    @IBAction func imageTapGesture(_ sender: UITapGestureRecognizer) {
        self.showImageViewController()
    }
    
    @IBAction func nextAction(_ sender: Any) {
        self.performSegue(withIdentifier: "todescribe", sender: self)
//        self.showImageViewController()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showinfo" {
            let infoController = segue.destination as! SCInfoViewController
            infoController.infoHeader = self.infoHeader
            infoController.infoDetail = self.infoDetail
            infoController.infoImage = self.infoImage
        }
    }
    
    // MARK: - Custom Methods
    
    func showImageViewController() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCImageViewController") as! SCImageViewController
        
        vc.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        vc.modalPresentationStyle = UIModalPresentationStyle.custom
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }

    // MARK: - SCImageViewProtocol
    func imageViewDissmissed() {
        

    }
}
