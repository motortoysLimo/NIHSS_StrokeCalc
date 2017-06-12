//
//  SCBestHorizontalGazeViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 10/28/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCBestHorizontalGazeViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var lightBulbButton: UIButton!
    @IBOutlet weak var shadow: UIView!
    @IBOutlet weak var yesButton: UIButton!
    @IBOutlet weak var noButton: UIButton!
    
    @IBOutlet weak var yesButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var noButtonHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
//        self.lightBulbButton.setShadowLayer()
        
        self.initUI()
    }

    @IBAction func lightBulpButtonTapped(_ sender: Any) {
        self.infoImage = #imageLiteral(resourceName: "lightbulb_icon")
        self.infoDetail = NSMutableAttributedString().normal(text: "For a patient that is ").underlinedNormal(text: "aphasic\n").normal(text: "or ").underlinedNormal(text: "confused").normal(text: ", ").normal(text: "use tracking.\n").bold(text: "Tracking").normal(text: ":").normal(text: " establishing eye contact and\nmoving about the patient from side to side while observing if the patient's\neyes follow your movement.\n\n").normal(text: "For a patient with ").underlinedNormal(text: "ocular trauma").normal(text: ",\n").underlinedNormal(text: "bandages").normal(text: ", ").underlinedNormal(text: "pre-existing blindness").normal(text: ", or\n").underlinedNormal(text: "other disorder of visual acuity").normal(text: " or\n").underlinedNormal(text: "fields").normal(text: ", ").normal(text: "tap ").bold(text: "Abnormal Gaze").normal(text: ".\n").normal(text: "\nFor a patient with isolated ").underlinedNormal(text: "cranial\nnerve paresis ").normal(text: "(CN, III, IV or VI),\ntap ").bold(text: "Abnormal Gaze").normal(text: ".")
        self.performSegue(withIdentifier: "showinfo", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func noAction(_ sender: AnyObject) {
        
        testScoreService.setIsGazeDeviated(isGazeDeviated: false)
        performSegue(withIdentifier: "toabnormal", sender: self)
    }
    
    @IBAction func yesAction(_ sender: AnyObject) {
//        performSegue(withIdentifier: "toabnormal", sender: self)
        
        // Score 0 (zero) points & go to Q3
        testScoreService.setScoresForQuestions(dictionary: [SCQType.Q2.rawValue: 0])
        
        performSegue(withIdentifier: "segue_visualfields", sender: self)
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
    
    func initUI() {
        
        self.yesButtonHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
        self.noButtonHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
        
        self.yesButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "YES", size: 20), for: UIControlState.normal)
        self.noButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "NO", size: 20), for: UIControlState.normal)
        
//        if SCAnswerStatus.sharedInstance.isAdjustForGuardRail1 {
//            self.tableView.bounces = true
//            self.tableView.alwaysBounceVertical = true
//            self.tableView.isScrollEnabled = true
//        }else {
//            self.tableView.bounces = false
//            self.tableView.alwaysBounceVertical = false
//            self.tableView.isScrollEnabled = false
//        }
    }
    
    // MARK: - UITableViewDelegate / UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if SCAnswerStatus.sharedInstance.isAdjustForGuardRail1 {
            return SCUtils.shared.sizeFor(value: 580)
        }else {
            return SCUtils.shared.sizeFor(value: 480)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! SCDetailTableViewCell
        
        cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "2. Best Horizontal Gaze")
        
        if SCAnswerStatus.sharedInstance.isAdjustForGuardRail1 {
            cell.contentLabel.attributedText = NSMutableAttributedString().normal(text: "Establish eye contact with the patient and move from one side of the bed to another, then ").orangeBold(text: "EVALUATE THE HORIZONTAL MOVEMENT").normal(text: " of both eyes as the patient follows you.\n\nThis is normal eye movement ").bold(text: "when tracking:")
        }else {
            cell.contentLabel.attributedText = NSMutableAttributedString().normal(text: "Ask the patient to ").orangeBold(text: "FOLLOW YOUR FINGER").normal(text: ", from side to side, then ").orangeBold(text: "EVALUATE HORIZONTAL MOVEMENT").normal(text: " of both eyes.")
        }
        
        cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "Do both eyes more EXACTLY like the video above?")
        
        return cell;
    }
    
}


