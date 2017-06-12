//
//  SCQ11ExtinctionAndNeglectViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 12/11/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ11ExtinctionAndNeglectViewController: SCBaseViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Properties
    
    @IBOutlet weak var continueButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var continueButton: SCAnswerButton!
    
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.continueButtonHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
        self.continueButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "CONTINUE", size: 20), for: UIControlState.normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - UITableViewDelegate and UITableViewDataSource
    
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
        
        cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "11. Extinction & Neglect")
        cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "Perform bilateral simultaneous TACTILE stimulation:\n\n1. Left side: Touch the patient's\n  hands OR feet. Ask them which side\n  you touched.\n2. Right side: touch the patient's hands OR feet. Ask them which side you touched.")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
    }
    
    // MARK: - UIButton Actions

    @IBAction func continueAction(_ sender: Any) {
        self.performSegue(withIdentifier: "toq11both", sender: self)
    }

}
