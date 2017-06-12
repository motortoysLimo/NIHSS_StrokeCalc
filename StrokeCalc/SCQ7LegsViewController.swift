//
//  SCQ7LegsViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 11/3/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class SCQ7LegsViewController: SCBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK: - Properties
    
    var isAtaxiaForArm = false
    var isAtaxiaForLeg = false
    
    var player: AVPlayer?
    
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return SCUtils.shared.sizeFor(value: 540)
        } else {
            return SCUtils.ComponentSize.BUTTON_HEIGHT
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell") as! SCDetailTableViewCell
            
            cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "7. Presence of Ataxia in\nLegs")
            cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "Perform the heel-to-shin exam like the video below.")
            cell.descriptionLabel.attributedText = NSMutableAttributedString().normal(text: "Evaluate each leg starting with the\nnon-paralyzed leg.\nDid the patient perform the heel-to-\nshin exam in BOTH legs like the above\nvideo?")
            
            // -- Play Video Part
            if let path = Bundle.main.path(forResource: "AtaxiaLeg", ofType: "mp4") {
                
                let playerVC = AVPlayerViewController()
                player = AVPlayer(url: URL(fileURLWithPath: path))
                playerVC.player = player
                playerVC.view.frame = cell.videoView.bounds
                self.addChildViewController(playerVC)
                cell.videoView.addSubview(playerVC.view)
                playerVC.didMove(toParentViewController: self)
                player?.seek(to: kCMTimeZero)
                player?.play()

            }else {
                debugPrint("AtaxiaLeg.mp4 not found")
            }
            
            return cell
        } else if indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "centeredcell") as! SCCenteredLabelTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Able to perform with both legs\n(No Ataxia)", size: 17, alignment: .left)
            
            return cell
        } else if indexPath.row == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "centeredcell") as! SCCenteredLabelTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Unable to perform with one or both legs \n(Ataxia)", size: 17, alignment: .left)
            
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "centeredcell") as! SCCenteredLabelTableViewCell
            
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "UNTESTABLE", size: 17, alignment: .left)
            
            return cell
        }
        return defaultCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            return
        }
        
        if indexPath.row == 2 { // Ataxia
            self.isAtaxiaForLeg = true
        }else {
            self.isAtaxiaForLeg = false
        }
        
        var score: Int = 0
        if self.isAtaxiaForArm && self.isAtaxiaForLeg { // 2 pts
            score = 2
        }else if !self.isAtaxiaForArm && !self.isAtaxiaForLeg { // 1 pts
            score = 0
        }else {
            score = 1
        }
        
        testScoreService.setScoresForQuestions(dictionary: [SCQType.Q7.rawValue: score])
        
        performSegue(withIdentifier: "toq8", sender: self)
    }

}
