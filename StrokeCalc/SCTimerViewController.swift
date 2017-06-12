//
//  SCTimerViewController.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 29/03/2017.
//  Copyright © 2017 Mobile Guru. All rights reserved.
//

import UIKit

class SCTimerViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var timerLabel: UILabel!
    
    var totalTime: Int = 10
    var currentTime: Int = 10
    var timer: Timer?
    
    let FONT_SIZE: CGFloat = 120.0
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        currentTime = totalTime

        self.timerLabel.setShadowLayer()
        self.timerLabel.alpha = 0.0
        self.timerLabel.layer.cornerRadius = SCUtils.ScreenSize.SCREEN_WIDTH * 100.0 / 375.0
        self.timerLabel.clipsToBounds = true
        self.timerLabel.layer.borderWidth = 5
        self.timerLabel.layer.borderColor = UIColor.prnBlue.cgColor
        
        self.timerLabel.attributedText = NSMutableAttributedString().boldBlue(text: "\(self.currentTime)", size: FONT_SIZE, align:NSTextAlignment.center)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showTimerLabel()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func showTimerLabel() {
        self.timerLabel.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.timerLabel.alpha = 1.0
            self.timerLabel.transform = .identity
            self.view.layoutIfNeeded()
        }
            , completion: { (finished) in
                self.timerLabel.isUserInteractionEnabled = true
                if #available(iOS 10.0, *) {
                    self.timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
                        
                        if self.currentTime <= 0 {
                            timer.invalidate()
                            self.timer = nil
                            
                            self.dismiss(animated: true, completion: nil)
                        }else {
                            
                            self.currentTime -= 1
                            self.timerLabel.attributedText = NSMutableAttributedString().boldBlue(text: "\(self.currentTime)", size: self.FONT_SIZE, align:NSTextAlignment.center)
                        }
                    })
                } else {
                    // Fallback on earlier versions
                    //            var timer = NSTimer.scheduledTimerWithTimeInterval(0.4, target: self, selector: #selector(MyClass.update), userInfo: nil, repeats: true)
                }
        })
    }
    
    // MARK: - Public Methods
    
    func setTime(value: Int) {
        totalTime = value
    }

}
