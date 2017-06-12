//
//  SCQ3VisionPeripheralViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 1/31/17.
//  Copyright © 2017 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ3VisionPeripheralViewController: SCBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var yesButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var noButtonHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var yesButton: SCAnswerButton!
    @IBOutlet weak var noButton: SCAnswerButton!
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.yesButtonHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
        self.noButtonHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
        
        self.yesButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "YES", size: 20).blueButton(text: "\nCoherent", size: 14), for: UIControlState.normal)
        self.noButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "NO", size: 20).blueButton(text: "\nIncoherent", size: 14), for: UIControlState.normal)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCUtils.shared.sizeFor(value: 700)
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell") as! SCDetailTableViewCell
        
        cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "3. Vision\nPeripheral Vision")
        cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "Does the patient appear to have intact peripheral vision?")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }

}
