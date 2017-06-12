//
//  SCQ3LeftEyeVisualFieldViewController.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 2/11/17.
//  Copyright © 2017 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ3LeftEyeVisualFieldViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties

    var leftStatus = [Int](repeating: 0, count: 4)
    
    var scoringPanelVC: SCScoringPanelViewController?
    
    @IBOutlet weak var normalButton: UIButton!
    @IBOutlet weak var abnormalButton: UIButton!
    
    @IBOutlet weak var lightButton: UIButton!
    
    @IBOutlet weak var normalButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var abnormalButtonHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.initUI()
//        self.lightButton.setShadowLayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showinfo" {
            let infoController = segue.destination as! SCInfoViewController
            infoController.infoHeader = self.infoHeader
            infoController.infoDetail = self.infoDetail
            infoController.infoImage = self.infoImage
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func lighthubTouchUp(_ sender: SCRoundButton) {
        self.infoImage = #imageLiteral(resourceName: "lightbulb_icon")
        self.infoDetail = NSMutableAttributedString().normal(text: "Question 3 tests the visual fields of both eyes. In this exam, each eye is examined independently. Upper and lower quadrants are assessed with ").bold(text: "confrontation").normal(text: ", which can be finger movement, finger counting or \"visual threat\". Make sure the patient is ALWAYS looking in your eyes or at your nose throughout the examination. It is important to know the range of the patient's peripheral vision. This helps to establish the correct position for testing the visual fields.\n").imageWith(name: "bilateral").normal(text: "\nStart aside the patients left ear, with your fingers extended and wigging. Move your hand slowly in an arc around the patient's face and ask them to tell you when they see your fingers.\nYou have now established the correct position for testing the LEFT field vision.\n\nOnce the range of peripheral vision is established, the visual field of each eyes is evaluated in random order. When vision is absent or impaired in only one quadrant of the visual field, it is referred to as a ").bold(text: "quadrantanopia").normal(text: ". If the same quadrant is affected in both eyes, it is a ").bold(text: "homonymous duadrantanopia").normal(text: " or partial hemianopia. Score 1 only if ").underlinedNormal(text: "clear-cut asymmetry between upper and lower fields").normal(text: ", including quandrantanopia is found.\n").imageWith(name: "bilateral").normal(text: "\nWhen vision is absent or impaired on one entire side of the visual field (both an upper and lower quadrant), this is referred to as ").bold(text: "hemianopia").normal(text: " (half vision). If the same side is affected in both eyes, it is referred to as ").bold(text: "homonymous hemianopia").normal(text: " or ").bold(text: "complete hemianopia").normal(text: " (Score = 2).\n").imageWith(name: "homonymous").normal(text: "\nIf patient is blind from any cause, score 3 for ").bold(text: "bilateral hemianopia").normal(text: ".\n").imageWith(name: "quadrantanopia").normal(text: "\n  • If there is ").underlinedNormal(text: "unilateral blindness").normal(text: " or\n    enucleation, visual fields in\n    remaining eye are scored.\n  • If the patient is unable to tell you\n    OR show you how many fingers\n    you are holding up, you may use\n    \"visual threat\" to determine\n    whether they blink when you\n    move your fingers at their eyes.\n    To perform visual threat,\n    point your index finger at the\n    patient's pupil from 12 inches\n    away. Thrust your finger towards\n    the pupil being careful not to\n    make contact with patient's eye.\n    Repeat this from all four quadrants\n    and observed if the patient blinks\n    or closes the eyes protectively.\n    A visual field deficit would be\n    suggested if the patient blinks\n    from some directions but not\n    others.\n  • Confused patients may need\n    constant reminding to maintain\n    their gaze on your nose.\n  • If the aphasic of confused patient\n    looks towards the correct side\n    of the moving finger, it is\n    considered to be a normal and\n    therefore scored zero (0).\n")
        
        self.performSegue(withIdentifier: "showinfo", sender: self)
    }

    // MARK: - Button Actions
    
    @IBAction func abnormalTouchUp(_ sender: UIButton) {
        self.nextPerform()
    }
    
    @IBAction func normalTouchUp(_ sender: UIButton) {
        self.nextPerform()
    }
    
    @IBAction func areaTouchUp(_ sender: UIButton) {
        if sender.isSelected == false {
            sender.isSelected = true
            self.leftStatus[sender.tag] = 1
        }else {
            sender.isSelected = false
            self.leftStatus[sender.tag] = 0
        }
        
        // Check whether the Left Eye is normal or abnormal
        var isNormal = true
        for item in self.leftStatus {
            if item == 1 {
                isNormal = false
            }
        }
        
        if isNormal {
            self.normalButton.isEnabled = true
            self.normalButton.setBackgroundColor(color: UIColor.prnCellNormalColor, forState: UIControlState.normal)
            self.normalButton.setAttributedTitle(NSMutableAttributedString().button(text: "LEFT EYE\nNORMAL", size: 20, color: UIColor.prnBlue), for: UIControlState.normal)
            
            self.abnormalButton.isEnabled = false
            self.abnormalButton.setBackgroundColor(color: UIColor.prnGray, forState: UIControlState.normal)
            self.abnormalButton.setAttributedTitle(NSMutableAttributedString().button(text: "LEFT EYE\nABNORMAL", size: 20, color: UIColor.white), for: UIControlState.normal)
        }else {
            self.normalButton.isEnabled = false
            self.normalButton.setBackgroundColor(color: UIColor.prnGray, forState: UIControlState.normal)
            self.normalButton.setAttributedTitle(NSMutableAttributedString().button(text: "LEFT EYE\nNORMAL", size: 20, color: UIColor.white), for: UIControlState.normal)
            
            self.abnormalButton.isEnabled = true
            self.abnormalButton.setBackgroundColor(color: UIColor.prnCellNormalColor, forState: UIControlState.normal)
            self.abnormalButton.setAttributedTitle(NSMutableAttributedString().button(text: "LEFT EYE\nABNORMAL", size: 20, color: UIColor.prnBlue), for: UIControlState.normal)
        }
    }
    
    // MARK: - Custom Methods
    
    func initUI() {
        self.normalButtonHeightConstraint.constant = SCUtils.shared.sizeFor(value: 65)
        self.abnormalButtonHeightConstraint.constant = SCUtils.shared.sizeFor(value: 65)
        
        self.normalButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "LEFT EYE\nNORMAL", size: 20), for: UIControlState.normal)
        self.abnormalButton.setAttributedTitle(NSMutableAttributedString().button(text: "LEFT EYE\nABNORMAL", size: 20, color:UIColor.white), for: UIControlState.normal)
        self.abnormalButton.setBackgroundColor(color: UIColor.prnGray, forState: UIControlState.normal)
        
        self.normalButton.isEnabled = true
        self.abnormalButton.isEnabled = false
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
            return SCUtils.shared.sizeFor(value: 870)
        }else {
            return SCUtils.shared.sizeFor(value: 890)
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eyeCell", for: indexPath) as! SCEyeTableViewCell
        
        if SCAnswerStatus.sharedInstance.isAdjustForGuardRail1 {
            cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "3. Left Eye Visual Field\nusing Visual Threat")
            cell.description1.attributedText = NSMutableAttributedString().normal(text: "1. Hold the patient's left eye open.\n2. Start with your finger pointed at\n   the patient's pupil from 12\" away\n   and thrust your finger towards the\n   eye. Be careful not to make\n   contact.\n3. Repeat in all four quadrants and\n   observe if patient blinks or closes\n   eyes.")
            cell.description2.attributedText = NSMutableAttributedString().normal(text: "4. Tap the areas where vision is\n   abnormal (you may select more\n   than one area).")
        }else {
//            self.lightButton.isHidden = true
            cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "3. Left Eye Visual Field")
            cell.description1.attributedText = NSMutableAttributedString().normal(text: "1. Cover the patient's RIGHT eye.\n2. Ask the patient to keep looking at\n   your nose during the exam.\n3. Tap the LIGHTBULB if you need\n   more instructions for this exam.\n4. Hold up 1 or 2 fingers in the\n   four marked areas, and ask the\n   patient to tell (or show) you\"how\n   many fingers?\"\n5. Test all quadrants.")
            cell.description2.attributedText = NSMutableAttributedString().normal(text: "6. Tap the areas where vision is\n   abnormal (you may select more\n   than one area).")
        }
        
        cell.aButton.tag = 0
        cell.bButton.tag = 1
        cell.cButton.tag = 2
        cell.dButton.tag = 3
        
        return cell
    }
    
    // MARK: - next action
    
    func nextPerform() {
        
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ3RightEyeVisualFieldViewController") as! SCQ3RightEyeVisualFieldViewController

        vc.leftStatus = self.leftStatus
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
