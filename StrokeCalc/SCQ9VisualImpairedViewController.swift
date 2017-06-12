//
//  SCQ9VisualImpairedViewController.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 2/15/17.
//  Copyright © 2017 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ9VisualImpairedViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    // MARK: - Properties

    @IBOutlet weak var glassesButton: SCRoundButton!
    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var yesButton: UIButton!
    
    @IBOutlet weak var noButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var yesButtonHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        self.glassesButton.setShadowLayer()
        self.initUI()
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

    // MARK: - UIButton Actions
    @IBAction func glassesTapped(_ sender: SCRoundButton) {
        self.infoImage = #imageLiteral(resourceName: "glasses_icon")
        self.infoDetail = NSMutableAttributedString().normal(text: "Please remind the patient to wear their glasses when you see the icon.")//\n\nIf the patient does not have their glasses or has difficulty with vision, you may tap on this icon for tips to modify the exam to fit the patient's needs.")
        self.performSegue(withIdentifier: "showinfo", sender: self)
    }
    
    @IBAction func noTouchUp(_ sender: UIButton) { // move to Best Language -  Naming Objects
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ9NamingObjectsViewController") as! SCQ9NamingObjectsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func yesTouchUp(_ sender: UIButton) { // 0 point
        
        testScoreService.setScoresForQuestions(dictionary: [SCQ9Type.Q9A.rawValue: 0])
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ9RepeatingSentencesViewController") as! SCQ9RepeatingSentencesViewController
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func initUI() {
        self.noButtonHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
        self.yesButtonHeightConstraint.constant = SCUtils.ComponentSize.BUTTON_HEIGHT
        
        self.yesButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "YES", size: 20), for: UIControlState.normal)
        self.noButton.setAttributedTitle(NSMutableAttributedString().blueButton(text: "NO", size: 20), for: UIControlState.normal)
    }
    
    // MARK: - UITableViewDelegate & UITableViewDataSource
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return SCUtils.shared.sizeFor(value: 480)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! SCDetailTableViewCell
        
        cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "9. Best Language - \nNaming Objects in a Visually\nImpaired Patient")
        cell.contentLabel.attributedText = NSMutableAttributedString().normal(text: "Hand the patient 5 or 6 common items for him ").orangeBold(text: "TO FEEL AND DESCRIBE").normal(text: ". Examples of items include:\n    • cup\n    • ballpoint pen\n    • magazine\n    • comb\n    • toothbrush\n    • keys\nDoes the patient correctly identify ALL objects?")
        
        return cell
    }
    
}
