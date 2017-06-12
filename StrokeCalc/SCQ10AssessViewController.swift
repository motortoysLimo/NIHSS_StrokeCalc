//
//  SCQ10AssessViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 12/11/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ10AssessViewController: SCBaseViewController, UITableViewDataSource , UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 270
        } else {
            return 92
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell") as! SCDetailTableViewCell
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "centeredcell") as! SCCenteredLabelTableViewCell
            cell.answerLabel.attributedText = NSAttributedString(string: "Clear and normal", attributes: cell.answerLabel.attributedText!.attributes(at: 0, effectiveRange: nil))
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "doublecell") as! SCDoubleTextTableViewCell
            cell.titleText.attributedText = NSAttributedString(string: "Some slurring", attributes: cell.titleText.attributedText!.attributes(at: 0, effectiveRange: nil))
            cell.subtitleText.attributedText = NSAttributedString(string: "Words are understandable.", attributes: cell.subtitleText.attributedText!.attributes(at: 0, effectiveRange: nil))
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "doublecell") as! SCDoubleTextTableViewCell
            cell.titleText.attributedText = NSAttributedString(string: "Severely slurred", attributes: cell.titleText.attributedText!.attributes(at: 0, effectiveRange: nil))
            cell.subtitleText.attributedText = NSAttributedString(string: "Speech cannot be understood in any meaningful way.", attributes: cell.subtitleText.attributedText!.attributes(at: 0, effectiveRange: nil))
            return cell
        }
        return defaultCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toq10repeat", sender: self)
    }

}
