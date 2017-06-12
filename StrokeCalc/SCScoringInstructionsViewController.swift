//
//  SCScoringInstructionsViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 10/25/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCScoringInstructionsViewController: SCBaseViewController,UIScrollViewDelegate, SCAlertServiceProtocol {

    // MARK: - Properties
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var mimicLabel: UILabel!
    @IBOutlet weak var lightLabel: UILabel!
    @IBOutlet weak var glassLabel: UILabel!
    @IBOutlet weak var dictionaryLabel: UILabel!
    @IBOutlet weak var playLabel: UILabel!
    @IBOutlet weak var coachLabel: UILabel!
    
    @IBOutlet weak var halfBackgroundView: UIView!
    
    // Overlay View
    var overlayView: UIView?
    
    var gotItButton: UIButton?
    var instructImageView: UIImageView?
    var instructView: UIView?
    var instructLabel: UILabel?
    var instructBackground: UIImageView?
    
    // Constraints
    
    @IBOutlet weak var tableViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButtonBottomConstraint: NSLayoutConstraint!
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.initUI()
        
        testScoreService.resetAllData()
        self.hideButton()
        
        self.nextButton.setBackgroundColor(color: UIColor.init(red: 208, green: 225, blue: 236, transperancy: 1.0), forState: .highlighted)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        var vHei:CGFloat
        if SCUtils.DeviceType.IS_IPHONE_5 || SCUtils.DeviceType.IS_IPHONE_4_OR_LESS{
            vHei = SCUtils.shared.sizeFor(value: 1170)
        }else {
            vHei = SCUtils.shared.sizeFor(value: 1080)
        }
        self.contentView.frame.size = CGSize(width: self.view.frame.width, height: vHei)
        self.tableView.contentSize = CGSize(width: self.view.frame.width, height: vHei)
        
        self.tableView.layoutIfNeeded()
        
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)) {
            self.showNextButton()
        }
    }
    
    // MARK: - Custom Methods
    
    func initUI() {
        self.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "Scoring Instructions for the NIHSS StrokeCalc")
        self.contentLabel.attributedText = NSMutableAttributedString().normal(text: "•  Score the patient's first response.\n•  Do not go back and change scores.\n•  Score what patient does, not what\n   you think the patient can do.\n•  Do not coach the patient ").bold(text: "unless\n   noted").normal(text: ". Coaching includes repeated\n   requests to make an effort OR\n   encouraging the patient to\n   respond.\n•  Pay attention when you see words\n   or icons in ").orangeBold(text: "ORANGE").normal(text: " because you\n   will be required to perform an\n   action.")
        self.timerLabel.attributedText = NSMutableAttributedString().normal(text: "Use the timer for the test.")
        self.descriptionLabel.attributedText = NSMutableAttributedString().boldBlue(text: "Icons that may help when going through the app:", size: 18)
        self.mimicLabel.attributedText = NSMutableAttributedString().normal(text: "OK to pantomime, (act out for the patient to follow).")
        self.lightLabel.attributedText = NSMutableAttributedString().normal(text: "Additional tips or instructions.")
        self.glassLabel.attributedText = NSMutableAttributedString().normal(text: "Reminder for the patient to wear glasses.")
        self.dictionaryLabel.attributedText = NSMutableAttributedString().normal(text: "Check full meaning of words and expressions.")
        self.playLabel.attributedText = NSMutableAttributedString().normal(text: "Play the video demonstrating the exam.")
        self.coachLabel.attributedText = NSMutableAttributedString().normal(text: "OK to \"coach\" the patient (encourage and cheer).")
        
        self.nextButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "NEXT", size: 20), for: UIControlState.normal)
        
        self.nextButtonHeightConstraint.constant = SCUtils.ScreenSize.SCREEN_HEIGHT * 65 / 667.0
        
//        self.contentView.frame.size = CGSize(width: self.view.frame.width, height: SCUtils.ScreenSize.SCREEN_HEIGHT * 1300 / 667.0)
//        self.contentView.frame = CGSize
//        self.tableView.contentSize = CGSize(width: self.view.frame.width, height: SCUtils.ScreenSize.SCREEN_HEIGHT * 1300 / 667.0)
    }
    
    func hideButton() {
        self.tableView.setNeedsUpdateConstraints()
        self.tableView.updateConstraints()
        self.nextButtonBottomConstraint.constant = SCUtils.ScreenSize.SCREEN_HEIGHT * 65 / 667.0
        
        UIView.animate(withDuration: 0.01, delay: 0.0, options: .curveEaseInOut, animations: {
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
            
        }, completion: { (finished) in
            self.updateViewConstraints()
            print(finished)
        })
    }
    
    func showNextButton() {
        self.tableView.setNeedsUpdateConstraints()
        self.tableView.updateConstraintsIfNeeded()
        self.nextButton.setNeedsUpdateConstraints()
        self.nextButton.updateConstraintsIfNeeded()
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            self.nextButtonBottomConstraint.constant = 0.0
            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }, completion: { (finished) in
            print(finished)
        })
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func next(_ sender: AnyObject) {
        
        if UserDefaults.standard.bool(forKey: "scoring_launched") == false {
            
            UserDefaults.standard.set(true, forKey: "scoring_launched")
            initOverlayView()
            self.addInstructor(itemIndex: 0)
        }else {
            self.showAlert()
        }
    }
    
    func showAlert() {
        let alertController = self.storyboard?.instantiateViewController(withIdentifier: "alertcontroller") as! SCAlertViewController
        alertController.alertWith(title: NSMutableAttributedString(string: ""), message: NSMutableAttributedString().normalBlue(text: "You are about to begin the NIHSS exam."), okButtonTitle: NSMutableAttributedString().blueButton(text: "OK. Got it!", size: 20), isLogo: false)
        alertController.delegate = self
        alertController.alertIdentifier = AlertStyle.rotateA
        alertController.modalTransitionStyle = .crossDissolve
        alertController.modalPresentationStyle = .overCurrentContext
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - SCAlertServiceProtocol
    
    func okButtonPressed(sender: UIButton) {
        self.performSegue(withIdentifier: "toq1", sender: self)
    }
    
    // MARK: - Instruction Methods
    
    func gotItTouchup(sender: UIButton) {
        
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.overlayView?.alpha = 0
            }, completion: { (isFinished) in
                self.overlayView?.removeFromSuperview()
                self.showAlert()
            })
    }
    
    func initOverlayView() {
        overlayView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height));
        
        gotItButton = UIButton(type: .system);
        gotItButton?.setAttributedTitle(NSMutableAttributedString().blueButton(text: "Got it!", size: 20), for: UIControlState.normal)
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
                    , y: UIScreen.main.bounds.size.height - 183
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
            
            self.instructImageView?.image = #imageLiteral(resourceName: "instruct_salog")
            self.instructImageView?.clipsToBounds = true
            self.instructImageView?.layer.cornerRadius = sw / 2
            self.instructImageView?.layer.borderColor = UIColor.white.cgColor
            self.instructImageView?.layer.borderWidth = 1
            self.instructImageView?.backgroundColor = UIColor(red: 38.0 / 255.0, green: 150.0 / 255.0, blue: 251.0 / 255.0, alpha: 1)
            
            self.overlayView?.addSubview(self.instructImageView!)
            
            // --------------- View
            var vw = UIScreen.main.bounds.size.width * 3 / 5;
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
            self.instructLabel?.attributedText = NSMutableAttributedString().normal(text: "Your instructions will always be here!")
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
    
}
