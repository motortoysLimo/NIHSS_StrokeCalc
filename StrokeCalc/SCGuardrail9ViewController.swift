//
//  SCGuardrail9ViewController.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 13/03/2017.
//  Copyright © 2017 Mobile Guru. All rights reserved.
//

import UIKit

class SCGuardrail9ViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    @IBOutlet weak var q9Label: UILabel!
    @IBOutlet weak var q11Label: UILabel!
    
    @IBOutlet weak var scoreViewTopConstraint: NSLayoutConstraint!
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.scoreViewTopConstraint.constant = -60

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            // Show the scoreView
            self.scoreViewTopConstraint.constant = 0
            self.view.layoutIfNeeded()
        }) { (isFinished) in
            // Hide scoreView 1s later
            let when = DispatchTime.now() + 1.5 // change 3 to desired number of seconds
            DispatchQueue.main.asyncAfter(deadline: when) {
                // Your code with delay
                UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                    self.scoreViewTopConstraint.constant = -60
                    self.view.layoutIfNeeded()
                }) { (isFinished) in
                    
                }
            }
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
    
    
    // MARK: - UITableViewDelegate and UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return SCUtils.shared.sizeFor(value: 550)
        }else {
            return SCUtils.shared.sizeFor(value: 65)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! SCDetailTableViewCell
            
            cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "Guardrail")
            cell.descriptionLabel.attributedText = NSMutableAttributedString().boldBlue(text: "Aphasia OR Neglect\n\n").normal(text: "Please note that aphasia and neglect are rarely present in the same patient at the same time.\n\nThe two most common exceptions to this finding:\n 1.  The patient has had more than\n     one new stroke (one in each\n     hemisphere).\n 2.  The patient has both a new stroke\n     and an old stroke (one in each\n     hemisphere).")
            
            return cell
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "centerCell", for: indexPath) as! SCCenteredLabelTableViewCell
            
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "ADD NOTE", size: 17, alignment: NSTextAlignment.center)
            
            return cell
        }else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "centerCell", for: indexPath) as! SCCenteredLabelTableViewCell
            
            cell.answerLabel.attributedText = NSMutableAttributedString().textForCell(text: "CONTINUE\n", size: 17, alignment: NSTextAlignment.center).textForCell(text: "Observation is correct", size: 14, alignment: NSTextAlignment.center)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // End exam
        SCUtils.shared.showEndExamAlert()
    }

}
