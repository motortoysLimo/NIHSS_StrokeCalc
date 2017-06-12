//
//  GCSTotalScoreViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 12/26/16.
//  Copyright © 2016 Mobile Guru. All rights reserved.
//


import UIKit

class GCSTotalScoreViewController: SCBaseViewController, UITableViewDataSource, UITableViewDelegate, SCGCSModalProtocol {
    
    // MARK: - Properties
    
    @IBOutlet weak var nextButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButton: SCAnswerButton!
    
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        self.nextButtonHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
        self.nextButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "NEXT", size: 20), for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITableViewDelegate / UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCUtils.ComponentSize.SIZE_450
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell") as! SCDetailTableViewCell
        
        cell.titleLabel.attributedText = NSMutableAttributedString().bold(text: "The patient's\nGlasgow coma score is:", size: 23, align: NSTextAlignment.center)
        
        cell.totalScore.attributedText = NSMutableAttributedString().mediumBlue(text: testScoreService.getScoreAsStringForQuestionNumberAsString(questionNumber: "GCS"), size: 30, align: NSTextAlignment.center)
        
        cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "If you have not already done so, please evaluate the patient's aurway to establish this is PATENT and MAINTAINABLE.")
        
        cell.totalScore.layer.cornerRadius = cell.totalScore.frame.size.width / 2
        cell.totalScore.clipsToBounds = true
        cell.totalScore.layer.borderColor = UIColor.prnBlue.cgColor
        cell.totalScore.layer.borderWidth = 2.0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    // MARK: - Custom Methods
    
    @IBAction func nextAction(_ sender: Any) {
        
        let noteModalVC = self.storyboard?.instantiateViewController(withIdentifier: "SCGCSModalViewController") as! SCGCSModalViewController
        noteModalVC.delegate = self
        noteModalVC.modalWith(title: NSMutableAttributedString().mediumBlue(text: "PLEASE NOTE:", size: 30, align: NSTextAlignment.center), content: NSMutableAttributedString().mediumBlue(text: "A GCS of 8 should not be used in isolation to make a determination of whether to intubate a patient, but does suggest a level of obtundation that should be evaluated carefully.", size: 17, align: NSTextAlignment.left))
        noteModalVC.modalTransitionStyle = .crossDissolve
        noteModalVC.modalPresentationStyle = .overCurrentContext
        self.present(noteModalVC, animated: true, completion: nil)
        
    }
    
    func drawCircle(countLabel : UILabel) {
        let padding : CGFloat = 0
        
        let x = countLabel.layer.position.x - (countLabel.frame.width / 2)
        let y = countLabel.layer.position.y  - (countLabel.frame.width / 2)
        let circlePath = UIBezierPath(roundedRect: CGRect(x: x - padding,y: y - padding, width: countLabel.frame.width + (2 * padding), height: countLabel.frame.width + (2 * padding)), cornerRadius: (countLabel.frame.width + (2 * padding)) / 2).cgPath
        
        let circleShape = CAShapeLayer()
        circleShape.path = circlePath
        circleShape.lineWidth = 2
        circleShape.strokeColor = UIColor.prnBlue.cgColor
        circleShape.fillColor = nil
        
        countLabel.layer.superlayer!.addSublayer(circleShape)
    }
    
    // MARK: - SCGCSModalProtocol
    
    func understandPressed() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCBestGazeFlow1ViewController") as! SCBestGazeFlow1ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
