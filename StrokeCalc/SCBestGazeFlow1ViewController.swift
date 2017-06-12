//
//  SCBestGazeFlow1ViewController.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 14/03/2017.
//  Copyright © 2017 Mobile Guru. All rights reserved.
//

import UIKit

class SCBestGazeFlow1ViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    @IBOutlet weak var seperateViewHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var neutralButton: SCAnswerButton!
    @IBOutlet weak var deviatedButton: SCAnswerButton!
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.seperateViewHeightConstraint.constant = SCUtils.shared.sizeFor(value: 65)
        
        self.neutralButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "NEUTRAL", size: 20.0), for: UIControlState.normal)
        self.deviatedButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "DEVIATED", size: 20.0), for: UIControlState.normal)
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
    
    @IBAction func neutralTouchUp(_ sender: SCAnswerButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCDeviatedAndFixedGazeViewController") as! SCDeviatedAndFixedGazeViewController
        vc.isNeutral = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func deviatedTouchUp(_ sender: SCAnswerButton) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCAbnormalEyeMovementViewController") as! SCAbnormalEyeMovementViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - UITableViewDelegate and UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCUtils.shared.sizeFor(value: 520)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! SCDetailTableViewCell
        
        cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "2. Best Horizontal Gaze\nIn a Patient That is Unable To Follow Commands")
        cell.questionInfolabel.attributedText = NSMutableAttributedString().blueBoldItalic(text: "This assessment necessitates examination of the oculocephalic (Doll's Eye) reflex.").normal(text: "\n\nLift the eyelids and observe the eyes at rest. If the eyes appear like the image below, tap ").bold(text: "NEUTRAL").normal(text: ".\nIf there is ANY difference or deviation in the resting position of the eyes from the image below, tap ").bold(text: "DEVIATED.")
        
        return UITableViewCell()
    }

}
