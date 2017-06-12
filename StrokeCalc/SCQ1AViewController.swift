//
//  SCQ1AViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 10/28/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ1AViewController: SCBaseViewController, UITableViewDataSource,UITableViewDelegate, SCGCSModalProtocol {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    let instruct_icons = ["instruct_salog", "instruct_menu", "dictionary_icon"]
    let instruct_texts = ["Your instructions will always be here!"
        , "Reset NIHSS Calculator!"
        , "Keep your eyes open for icons to guide you!"]
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    
    // Overlay View
    var overlayView: UIView?
    
    var gotItButton: UIButton?
    var instructImageView: UIImageView?
    var instructView: UIView?
    var instructLabel: UILabel?
    var instructBackground: UIImageView?
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.table.separatorColor = UIColor.init(red: 208, green: 225, blue: 236, transperancy: 1.0)
        // Do any additional setup after loading the view.
        self.initUI()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.bool(forKey: "q1a_launched") == false {
            
            UserDefaults.standard.set(true, forKey: "q1a_launched")
        
            initOverlayView()
            self.addInstructor(itemIndex: 1)
        }
    }
    
    @IBAction func dictionaryButtonTapped(_ sender: AnyObject) {
        
        self.infoImage = #imageLiteral(resourceName: "dictionary_icon")
        
        let button = sender as! UIButton
        
        if button.tag == 101 {
            
            self.performSegue(withIdentifier: "showinfo", sender: self)
            print("one point")
        } else if button.tag == 102 {
            self.infoDetail = NSMutableAttributedString().bold(text:"Not alert").normal(text: ", but arousable by minor stimulation to obey, answer or respond.")
            self.infoHeader = "Drowsy"
            self.performSegue(withIdentifier: "showinfo", sender: self)
        } else if button.tag == 103 {
            self.infoDetail = NSMutableAttributedString().bold(text: "Not alert").normal(text: ", but can attend after repeated stimulation.\n\nOR\n\n").bold(text: "Is obtunded").normal(text: " and requires strong or painful stimulation to make movements (not stereotyped)")
            self.infoHeader = "Stuporous"
            self.performSegue(withIdentifier: "showinfo", sender: self)
            print("three points")
        } else if button.tag == 104 {
            self.infoDetail = NSMutableAttributedString().normal(text: "Responds only with reflex motor or automatic effect.\n\nOR\n\n").bold(text: "Totally unresponsive").normal(text: ", flaccid and areflexic.")
            self.infoHeader = "Coma"
            self.performSegue(withIdentifier: "showinfo", sender: self)
            print("four points")
        }
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDelegate & UITableViewDataSource
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "answercell") as! SCAnswerTableViewCell
        
        if indexPath.row == 0 {
            cell.answerNumber.image = UIImage(named: "zero")
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Alert and response", size: 17, alignment: NSTextAlignment.left)
            cell.dictionaryButton.isHidden = true
            cell.dictionaryButton.tag = 101
        } else if indexPath.row == 1 {
            cell.answerNumber.image = UIImage(named: "one")
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Drowsy", size: 17, alignment: NSTextAlignment.left)
            cell.dictionaryButton.tag = 102
        } else if indexPath.row == 2 {
            cell.answerNumber.image = UIImage(named: "two")
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Stuporous", size: 17, alignment: NSTextAlignment.left)
            cell.dictionaryButton.tag = 103
        } else if indexPath.row == 3 {
            cell.answerNumber.image = UIImage(named: "three")
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Coma", size: 17, alignment: NSTextAlignment.left)
            cell.dictionaryButton.tag = 104
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let score = indexPath.row
        
        //Set value of 1A:
        testScoreService.setScoresForQuestions(dictionary: [SCQType.Q1A.rawValue: score])
        
        //Determine flow, score skipped questions for flow, and perform appropriate segue
        if ((score == 0) || (score == 1)) {
            if(testScoreService.isPatientIntubated()) {
                //Start of Flow 4
                testScoreService.setFlowNumber(newFlowNumber: 4)
                testScoreService.setScoresForQuestions(dictionary: [SCQType.Q1B.rawValue: 1, SCQType.Q10.rawValue: "UN"]) // Auto-Score UN
                
                // Go to Q1C
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ1CViewController") as! SCQ1CViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
//
                testScoreService.setScoreAnnotation(newScoreAnnotation: "Intubated", questionNumberAsString: SCQType.Q10.rawValue)
                testScoreService.setScoreAnnotation(newScoreAnnotation: "Intubated", questionNumberAsString: SCQType.Q1B.rawValue)
//
//                if (self.testScoreService.shouldAlertUserOnAutoscore()
//                    && (self.testScoreService.getModeCalculator() < self.testScoreService.kModeCalculatorAssisted) ) {
//                    let alertViewDidAutoscore = UIAlertView(
//                        title: "Info: Questions were Autoscored",
//                        message: "Your answer for this question has auto-scored Question 1B to 1 and Question 10 to a score of UN (Untestable).",
//                        delegate:nil,
//                        cancelButtonTitle:"OK"
//                    )
//                    alertViewDidAutoscore.show()
//                }
//                performSegue(withIdentifier: "goTo1C-from1A", sender: self)
            } else {
                //Start of Flow 3
                testScoreService.setFlowNumber(newFlowNumber: 3)
                performSegue(withIdentifier: "goTo1B", sender: self)
            }
        } else if (score == 2) {
            if(testScoreService.isPatientIntubated()) {
                //Start of Flow 6
                testScoreService.setFlowNumber(newFlowNumber: 6)
                
                testScoreService.setScoresForQuestions(dictionary: [SCQType.Q1B.rawValue: 1
                    , SCQType.Q7.rawValue: 0
                    , SCQType.Q8.rawValue: 1
                    , SCQType.Q9.rawValue: 2
                    , SCQType.Q10.rawValue: "UN"
                    , SCQType.Q11.rawValue: 0])
                
                testScoreService.setScoreAnnotation(newScoreAnnotation: "Can't understand instructions", questionNumberAsString: SCQType.Q7.rawValue)
                testScoreService.setScoreAnnotation(newScoreAnnotation: "Intubated", questionNumberAsString: SCQType.Q10.rawValue)
                testScoreService.setScoreAnnotation(newScoreAnnotation: "Intubated", questionNumberAsString: SCQType.Q1B.rawValue)
                
                if (self.testScoreService.shouldAlertUserOnAutoscore()
                    && (self.testScoreService.getModeCalculator() < self.testScoreService.kModeCalculatorAssisted) ) {
//                    let alertViewDidAutoscore = UIAlertView(
//                        title: "Info: Questions were Autoscored",
//                        message: "Your answer for this question has auto-scored Question 1B to 2, Question 7 to 0, Question 8 to 1, Question 9 to 2, Question 10 to UN and Question 11 to 2.",
//                        delegate:nil,
//                        cancelButtonTitle:"OK"
//                    )
//                    alertViewDidAutoscore.show()
                }
                
                // Go to Q1C
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ1CViewController") as! SCQ1CViewController
                self.navigationController?.pushViewController(vc, animated: true)
                
            } else {
                //Start of Flow 5
                testScoreService.setFlowNumber(newFlowNumber: 5)
                
                testScoreService.setScoresForQuestions(dictionary: [SCQType.Q1B.rawValue: 2
                    , SCQType.Q7.rawValue: 0
                    , SCQType.Q8.rawValue: 1
                    , SCQType.Q11.rawValue: 0]) // by definition, Q9 can not be 9
                
                testScoreService.setScoreAnnotation(newScoreAnnotation: "Can't understand instructions", questionNumberAsString: SCQType.Q7.rawValue)
                
                testScoreService.setScoreAnnotation(newScoreAnnotation: "Stuporous patient", questionNumberAsString: SCQType.Q8.rawValue)
                
                if (self.testScoreService.shouldAlertUserOnAutoscore()
                    &&  (self.testScoreService.getModeCalculator() < self.testScoreService.kModeCalculatorAssisted) ) {
//                    let alertViewDidAutoscore = UIAlertView(
//                        title: "Info: Questions were Autoscored",
//                        message: "Your answer for this question has auto-scored Question 1B to 2, Question 7 to 0, Question 8 to 1, Question 9 to 2, and Question 11 to 2.",
//                        delegate:nil,
//                        cancelButtonTitle:"OK"
//                    )
//                    alertViewDidAutoscore.show()
                }
                
                // Go to Q1C
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ1CViewController") as! SCQ1CViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else if (score == 3) {
            
            if(testScoreService.isPatientIntubated()) {
                tableView.deselectRow(at: indexPath, animated: true)
                //Start of Flow 1
                testScoreService.setScoresForQuestions(dictionary: [SCQType.Q1B.rawValue: 2
                    , SCQType.Q1C.rawValue: 2
                    , SCQType.Q3.rawValue: 3
                    , SCQType.Q5A.rawValue: 4
                    , SCQType.Q5B.rawValue: 4
                    , SCQType.Q6A.rawValue: 4
                    , SCQType.Q6B.rawValue: 4
                    , SCQType.Q7.rawValue: 0
                    , SCQType.Q8.rawValue: 2
                    , SCQType.Q9.rawValue: 3
                    , SCQType.Q10.rawValue: "UN"
                    , SCQType.Q11.rawValue: 2])
                // Q10: auto score UN
                testScoreService.setFlowNumber(newFlowNumber: 1)
                
                self.showModal()
                
                testScoreService.setScoreAnnotation(newScoreAnnotation: "Intubated", questionNumberAsString: SCQType.Q10.rawValue)
                testScoreService.setScoreAnnotation(newScoreAnnotation: "Intubated", questionNumberAsString: SCQType.Q1B.rawValue)
//
//                if (self.testScoreService.shouldAlertUserOnAutoscore()
//                    &&  (self.testScoreService.getModeCalculator() < self.testScoreService.kModeCalculatorAssisted) ) {
//                    let alertViewDidAutoscore = UIAlertView(
//                        title: "Info: Questions were Autoscored",
//                        message: "Your answer for this question has auto-scored Question 1B to 2, Question 1C to 2, Question 3 to 3, Question 5A to 4, Question 5B to 4, Question 6A to 4, Question 6B to 4, Question 7 to 0, Question 8 to 2, and Question 10 to UN (Untestable).",
//                        delegate:nil,
//                        cancelButtonTitle:"OK"
//                    )
//                    alertViewDidAutoscore.show()
//                }
                
//                performSegue(withIdentifier: "tobestgaze", sender: self)
            } else {
                //Start of Flow 2
                testScoreService.setFlowNumber(newFlowNumber: 2)
                
                testScoreService.setScoresForQuestions(dictionary: [SCQType.Q1B.rawValue: 2
                    , SCQType.Q1C.rawValue: 2
                    , SCQType.Q3.rawValue: 3
                    , SCQType.Q5A.rawValue: 4
                    , SCQType.Q5B.rawValue: 4
                    , SCQType.Q6A.rawValue: 4
                    , SCQType.Q6B.rawValue: 4
                    , SCQType.Q7.rawValue: 0
                    , SCQType.Q8.rawValue: 2
                    , SCQType.Q9.rawValue: 3
                    , SCQType.Q10.rawValue: 2
                    , SCQType.Q11.rawValue: 2])
                
                if (self.testScoreService.shouldAlertUserOnAutoscore()
                    &&  (self.testScoreService.getModeCalculator() < self.testScoreService.kModeCalculatorAssisted) ) {
//                    let alertViewDidAutoscore = UIAlertView(
//                        title: "Info: Questions were Autoscored",
//                        message: "Your answer for this question has auto-scored Question 1B to 2, Question 1C to 2, Question 3 to 3, Question 5A to 4, Question 5B to 4, Question 6A to 4, Question 6B to 4, Question 7 to 0, Question 8 to 2, and Question 10 to 2.",
//                        delegate:nil,
//                        cancelButtonTitle:"OK"
//                    )
//                    alertViewDidAutoscore.show()
                }
                performSegue(withIdentifier: "togcs", sender: self)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCUtils.ComponentSize.BUTTON_HEIGHT
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showinfo" {
        let infoController = segue.destination as! SCInfoViewController
            infoController.infoHeader  = self.infoHeader
            infoController.infoDetail = self.infoDetail
            infoController.infoImage = self.infoImage
        }
    }
    
    
    // MARK: - Custom Methods
    
    func initUI() {
        self.tableViewHeightConstraint.constant = SCUtils.shared.sizeFor(value: 65) * 4
        
        self.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "1A. Levels of Consciousness")
        self.contentLabel.attributedText = NSMutableAttributedString().normal(text: "What is the patient's level of consciousness?")
    }
    
    func showModal() {
        
        let modalVC = self.storyboard?.instantiateViewController(withIdentifier: "SCGCSModalViewController") as! SCGCSModalViewController
        
        modalVC.modalWith(title: NSMutableAttributedString().boldRed(text: "WARNING:", size: 35, align: NSTextAlignment.center), content: NSMutableAttributedString().boldBlue(text: "Because the ", size: 18).boldRed(text: "patient is intubated,", size: 18, align: NSTextAlignment.center).boldBlue(text: " take appropriate precautions to ensure a secure airway and avoid accidental extubation.", size: 18))
        modalVC.delegate = self
        modalVC.modalTransitionStyle = .crossDissolve
        modalVC.modalPresentationStyle = .overCurrentContext
        
        self.present(modalVC, animated: true, completion: nil)
    }
    
    // MARK: - Instruction Methods
    
    func gotItTouchup(sender: UIButton) {
        
        if sender.tag > 2 {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.overlayView?.alpha = 0
            }, completion: { (isFinished) in
                self.overlayView?.removeFromSuperview()
            })
        }else {
            addInstructor(itemIndex: sender.tag)
        }
    }
    
    func initOverlayView() {
        overlayView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height));
        
        gotItButton = UIButton(type: .system);
        
        gotItButton?.setAttributedTitle(NSMutableAttributedString().blueButton(text: "Got it!", size: 20), for: .normal)
        gotItButton?.addTarget(self, action: #selector(gotItTouchup(sender:)), for: .touchUpInside)
        self.gotItButton?.titleLabel?.font = UIFont.systemFont(ofSize: 19.0, weight: UIFontWeightMedium)
        //        gotItButton?.backgroundColor = UIColor.black
        gotItButton?.isHidden = true
        // --
        let currentWindow = UIApplication.shared.keyWindow
        overlayView?.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 0.5)
        overlayView?.isHidden = false
        currentWindow?.addSubview(overlayView!);
    }
    
    // Add instructor
    func addInstructor(itemIndex: Int) {
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            var convertedFrame = CGRect(x: 0, y: 0, width: 0, height: 0)
            var sw: CGFloat = 0.0
            
            if itemIndex == 0 {
                let rightBarView: UIView = self.navigationItem.rightBarButtonItem?.value(forKey: "view") as! UIView
                convertedFrame = rightBarView.convert(rightBarView.bounds, to: self.overlayView)
                sw = (convertedFrame.size.height) * 1.3
            }else if itemIndex == 1 {
                convertedFrame = CGRect(x: UIScreen.main.bounds.size.width - 50
                    , y: 69
                    , width: 40, height: 40)
                sw = (convertedFrame.size.height)
            }else {
                convertedFrame = CGRect(x: UIScreen.main.bounds.size.width - 65
                    , y: UIScreen.main.bounds.size.height - (SCUtils.shared.sizeFor(value: 65) * 3 - (SCUtils.shared.sizeFor(value: 65) - 40) / 2)
                    , width: 40, height: 40)
                sw = (convertedFrame.size.height)
            }
            
            let sx = (convertedFrame.origin.x) + ((convertedFrame.size.width) - sw) / 2
            let sy = (convertedFrame.origin.y) + ((convertedFrame.size.height) - sw) / 2
            
            self.instructImageView?.removeFromSuperview()
            self.instructImageView = nil
            self.instructImageView = UIImageView(frame: CGRect(x: sx
                , y: sy
                , width: sw
                , height: sw))
            //            }else {
            //                self.instructImageView?.frame = CGRect(x: sx
            //                    , y: sy
            //                    , width: sw
            //                    , height: sw)
            //            }
            
            self.instructImageView?.image = UIImage(named: self.instruct_icons[itemIndex]);
            self.instructImageView?.clipsToBounds = true
            self.instructImageView?.layer.cornerRadius = sw / 2
            self.instructImageView?.layer.borderColor = UIColor.white.cgColor
            self.instructImageView?.layer.borderWidth = 1
            self.instructImageView?.backgroundColor = UIColor(red: 38.0 / 255.0, green: 150.0 / 255.0, blue: 251.0 / 255.0, alpha: 1)
            
            self.overlayView?.addSubview(self.instructImageView!)
            
            // --------------- View
            var vw = UIScreen.main.bounds.size.width * 2 / 3;
            let vh = vw / 2;
            if SCUtils.DeviceType.IS_IPHONE_4_OR_LESS || SCUtils.DeviceType.IS_IPHONE_5 {
                vw = UIScreen.main.bounds.size.width * 7 / 10;
            }
            
            self.gotItButton?.frame = CGRect(x: vw - 80, y: vh - 35, width: 70, height: 30);
            self.gotItButton?.tag = itemIndex + 1
            
            var instructViewRect = CGRect(x: 0, y: 0, width: 0, height: 0)
            if itemIndex == 0 { // top-right
                instructViewRect = CGRect(x: sx - vw, y: sy + sw / 2, width: vw, height: vh)
            }else if itemIndex == 1 {
                instructViewRect = CGRect(x: sx - vw + sw / 2, y: sy + sw, width: vw, height: vh)
            }else { // tableview cell
                instructViewRect = CGRect(x: sx - vw, y: sy + sw / 2, width: vw, height: vh)
            }
            
            if self.instructView == nil {
                self.instructView = UIView(frame: instructViewRect);
            }else {
                self.instructView?.frame = instructViewRect;
            }
            
            self.instructView?.backgroundColor = UIColor.clear
            
            if self.gotItButton?.superview != self.instructView {
                self.instructView?.addSubview(self.gotItButton!);
            }
            
            // background image
            let instructBackground_rect = CGRect(x: 0, y: 0, width: vw, height: vh)
            if self.instructBackground == nil {
                self.instructBackground = UIImageView(frame: instructBackground_rect)
            }else {
                self.instructBackground?.frame = instructBackground_rect
            }
            self.instructBackground?.image = #imageLiteral(resourceName: "modal_sm")
//            self.instructBackground?.backgroundColor = UIColor.white
//            self.instructBackground?.layer.cornerRadius = 10
            self.instructBackground?.setShadowLayer()
            
            if self.instructBackground?.superview != self.instructView {
                self.instructView?.addSubview(self.instructBackground!)
            }
            
            // description label
            let margin = SCUtils.shared.sizeFor(value: 16)
            let instructLabel_rect = CGRect(x: margin, y: margin, width: vw - margin * 2, height: vh - 35)
            if self.instructLabel == nil {
                self.instructLabel = UILabel(frame: instructLabel_rect)
            }else {
                self.instructLabel?.frame = instructLabel_rect
            }

            self.instructLabel?.attributedText = NSMutableAttributedString().normal(text: self.instruct_texts[itemIndex])
            self.instructLabel?.textAlignment = .center
            self.instructLabel?.numberOfLines = 0
            self.instructLabel?.minimumScaleFactor = 8
            self.instructLabel?.adjustsFontSizeToFitWidth = true
            
            if self.instructLabel?.superview != self.instructView {
                self.instructView?.addSubview(self.instructLabel!)
            }
            
            self.instructView?.bringSubview(toFront: self.gotItButton!)
            
            self.instructView?.alpha = 0
            
            self.overlayView?.addSubview(self.instructView!)
            
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
                self.instructView?.alpha = 1
            }, completion: { (isFinished) in
                
            })
        }, completion: {(isFinished) in
            self.gotItButton?.isHidden = false
        })
        
    }
    
    // MARK: - SCGCSModalProtocol
    
    func understandPressed() {
        // show
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCBestGazeFlow1ViewController") as! SCBestGazeFlow1ViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
