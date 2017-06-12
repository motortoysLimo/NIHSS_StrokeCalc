//
//  SCGuardRail1ForFlow6ViewController.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 17/03/2017.
//  Copyright © 2017 Mobile Guru. All rights reserved.
//

import UIKit

class SCGuardRail1ForFlow6ViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource, SCGCSModalProtocol {
    
    // MARK: - Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        testScoreService.setFlowNumber(newFlowNumber: 6)
        tableView.reloadData()
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
    
    
    // MARK: - UITableViewDelegate / UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 3
        }else if section == 1 {
            return 3
        }else if section == 2 {
            return 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row > 0 {
            return SCUtils.shared.sizeFor(value: 65.0)
        }else { // == 0
            if indexPath.section == 0 {
                return SCUtils.shared.sizeFor(value: 350)
            }else if indexPath.section == 1 {
                return SCUtils.shared.sizeFor(value: 260)
            }else if indexPath.section == 2 {
                return SCUtils.shared.sizeFor(value: 200)
            }
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 { // Content Part
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "headerCell", for: indexPath) as! SCDetailTableViewCell
                cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "Guardrail")
                cell.questionInfolabel.attributedText = NSMutableAttributedString().boldBlue(text: "Your patient is having difficulty understanding and following instructions.\n\n").normal(text: "You have indicated that the patient is unable to speak. Is this because the patient is intubated?")
                
                return cell
            }else if indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "bodyCell", for: indexPath) as! SCDetailTableViewCell
                
                cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "You have indicated that the patient is stuporous. Is the patient obtunded but can attend to his surroundings, albeit briefly and with repeated stimulation? Or is the patient near unconscious and requires painful stimulatin to even make a movement?")
                
                return cell
            }else if indexPath.section == 2 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "bodyCell", for: indexPath) as! SCDetailTableViewCell
                
                cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "The remainder of this exam is adjusted for instructions and responses to be optimally suited for a patient with a decreased level of consciousness.")
                
                return cell
            }
        }else { // Action Part
            if indexPath.section == 0 || indexPath.section == 1 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "answerCell", for: indexPath) as! SCAnswerTableViewCell
                
                var str = ""
                let space = "            "
                if indexPath.section == 0 {
                    if indexPath.row == 1 {
                        str = space + "YES, Patient is intubated"
                        cell.statusImageView.isHidden = false
                    }else if indexPath.row == 2 {
                        str = space + "NO, Patient is not intubated"
                        cell.statusImageView.isHidden = true
                    }
                }else {
                    if indexPath.row == 1 {
                        str = space + "Requires repeated stimulation"
                        cell.statusImageView.isHidden = false
                    }else if indexPath.row == 2 {
                        str = space + "Is near unconscious"
                        cell.statusImageView.isHidden = true
                    }
                }
                
                cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: str, size: 17, alignment: NSTextAlignment.left)
                
                return cell
            }else if indexPath.section == 2 { // Next
                let cell = tableView.dequeueReusableCell(withIdentifier: "continueCell", for: indexPath) as! SCAnswerTableViewCell
                
                cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "CONTINUE", size: 17, alignment: NSTextAlignment.center)
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            return
        }
        
        if indexPath.section == 0 || indexPath.section == 1 {
            let cell = tableView.cellForRow(at: indexPath) as! SCAnswerTableViewCell
            cell.statusImageView.isHidden = false
            
            var otherCellRow = 1
            if indexPath.row == 1 {
                otherCellRow = 2
            }else if indexPath.row == 2 {
                otherCellRow = 1
            }
            let otherCell = tableView.cellForRow(at: IndexPath(row: otherCellRow, section: indexPath.section)) as! SCAnswerTableViewCell
            otherCell.statusImageView.isHidden = true
            
            // Process
            
            if indexPath.section == 0 && indexPath.row == 2 { // Return to Flow 5
                
                testScoreService.setFlowNumber(newFlowNumber: 5)
                
                self.showGuardrailForFlow5()
                
            }else if indexPath.section == 1 && indexPath.row == 2 { // Modal - Warning
                self.showModal()
            }
        }else if indexPath.section == 2 { // Continue
            // Guardrail 1D Trigger is always activated, it has no dependency for a trigger
            self.showBestHorizontalVC()
        }
        
    }
    
    // MARK: - Process next performs
    
    func showModal() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCGCSModalViewController") as! SCGCSModalViewController
        
        vc.modalWith(title: NSMutableAttributedString().boldRed(text: "WARNING:", size: 35, align: NSTextAlignment.center), content: NSMutableAttributedString().boldBlue(text: "Because the ", size: 18).boldRed(text: "patient is intubated,", size: 18, align: NSTextAlignment.center).boldBlue(text: " take appropriate precautions to ensure a secure airway and avoid accidental extubation.", size: 18))
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func showGuardrailForFlow5() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCGuardRail1ForFlow5ViewController") as! SCGuardRail1ForFlow5ViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showBestHorizontalForFlow1() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCBestGazeFlow1ViewController") as! SCBestGazeFlow1ViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showBestHorizontalVC() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCBestHorizontalForFlow5ViewController") as! SCBestHorizontalForFlow5ViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - SCGCSModalProtocol
    
    func understandPressed() {
        self.showBestHorizontalForFlow1()
    }

}
