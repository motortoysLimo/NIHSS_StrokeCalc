//
//  SCQ7ArmsViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 11/3/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ7ArmsViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    @IBOutlet weak var glassesButton: SCRoundButton!
    
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        self.glassesButton.setShadowLayer()
        if SCAnswerStatus.sharedInstance.isGuardRail2A {
            self.glassesButton.isHidden = true
        }else {
            self.glassesButton.isHidden = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func glassesIconTapped(_ sender: Any) {
        self.infoImage = #imageLiteral(resourceName: "glasses_icon")
        self.infoDetail = NSMutableAttributedString().normal(text: "Please remind the patient to wear their glasses when you see this icon.")
        self.performSegue(withIdentifier: "showinfo", sender: self)
    }
    
    // MARK: - Custom Methods
    
    // MARK: - UITableViewDelegate & UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if SCAnswerStatus.sharedInstance.isGuardRail2A {
                return SCUtils.shared.sizeFor(value: 430)
            } else {
                return SCUtils.shared.sizeFor(value: 540)
            }
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
            
            cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "7. Presence of Ataxia in Arms")
            
            if SCAnswerStatus.sharedInstance.isGuardRail2A {
                
                cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "Have the patient touch their nose from extended arm position like in the video below.")
                cell.descriptionLabel.isHidden = true
                
            }else {
                
                cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "Perform the finger-to-nose exam like the video below.")
                cell.descriptionLabel.attributedText = NSMutableAttributedString().normal(text: "Evaluate BOTH arms, starting with the non-paralyzed arms.\n\n").orangeBoldItalic(text: "In the affected arm, ataxia is present only when out of proportion to weakness.")
                
            }
            
            return cell
        } else if indexPath.row == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "centeredcell") as! SCCenteredLabelTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Able to perform with both arms\n(No Ataxia)", size: 17, alignment: .left)
            return cell
            
        } else if indexPath.row == 2 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "centeredcell") as! SCCenteredLabelTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "Unable to perform with one or both arms \n(Ataxia)", size: 17, alignment: .left)
            return cell
            
        } else if indexPath.row == 3 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "centeredcell") as! SCCenteredLabelTableViewCell
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "UNTESTABLE", size: 17, alignment: .left)
            return cell
        }
        return defaultCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ7LegsViewController") as! SCQ7LegsViewController
        
        if indexPath.row == 0 {
            return
        }
        
        if indexPath.row == 2 { //Ataxia
            vc.isAtaxiaForArm = true
        }else { // No Ataxia
            vc.isAtaxiaForArm = false
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showinfo" {
            let infoController = segue.destination as! SCInfoViewController
            infoController.infoHeader = self.infoHeader
            infoController.infoDetail = self.infoDetail
            infoController.infoImage = self.infoImage
        }
    }

}
