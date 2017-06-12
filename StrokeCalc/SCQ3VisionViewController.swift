//
//  SCQ3VisionViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 1/24/17.
//  Copyright © 2017 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ3VisionViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource, SCExtendedCellActionProtocol {
    
    
    // MARK: - Properties

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lightButton: UIButton!
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.tableView.register(UINib.init(nibName: "SCExtendedTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "visioncell")
//        self.lightButton.setShadowLayer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func lightBulpTapped(_ sender: Any) {
        
    }
    
    func infoButtonTappedWithTag(tag : Int) {
        switch tag {
        case 1:
            print("1")
            break
        case 2:
            break
        case 3:
            break
        case 4:
            break
        case 5:
            break
        default:
            break
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return SCUtils.shared.sizeFor(value: 290)
        } else {
            return SCUtils.shared.sizeFor(value: 65)
        }
    }
    
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let defaultCell = UITableViewCell()
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell") as! SCDetailTableViewCell
            
            cell.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "3. Vision")
            cell.questionInfolabel.attributedText = NSMutableAttributedString().normal(text: "Is the patient blind?")
            
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "visioncell") as! SCExtendedCell
            cell.answerLabel.attributedText = NSAttributedString(string: "Not sure", attributes: cell.answerLabel.attributedText!.attributes(at: 0, effectiveRange: nil))
            cell.answerLabel.font = UIFont(name: cell.answerLabel.font.fontName, size: SCUtils.ComponentSize.LABEL_FONT17)
            cell.actionButton.isHidden = false
            cell.actionButton.isEnabled = true
            cell.infoDelegate = self
            cell.actionButton.tag = 1
            return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "visioncell") as! SCExtendedCell
            cell.answerLabel.attributedText = NSAttributedString(string: "LEFT eye blind", attributes: cell.answerLabel.attributedText!.attributes(at: 0, effectiveRange: nil))
            cell.answerLabel.font = UIFont(name: cell.answerLabel.font.fontName, size: SCUtils.ComponentSize.LABEL_FONT17)
            cell.actionButton.isHidden = false
            cell.actionButton.isEnabled = true
            cell.infoDelegate = self
            cell.actionButton.tag = 2
            return cell
        } else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "visioncell") as! SCExtendedCell
            cell.answerLabel.attributedText = NSAttributedString(string: "RIGHT eye blind", attributes: cell.answerLabel.attributedText!.attributes(at: 0, effectiveRange: nil))
            cell.answerLabel.font = UIFont(name: cell.answerLabel.font.fontName, size: SCUtils.ComponentSize.LABEL_FONT17)
            cell.actionButton.isHidden = false
            cell.actionButton.isEnabled = true
            cell.infoDelegate = self
            cell.actionButton.tag = 3
            return cell
        } else if indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "visioncell") as! SCExtendedCell
            cell.answerLabel.attributedText = NSAttributedString(string: "BILATERAL blind (both eyes)", attributes: cell.answerLabel.attributedText!.attributes(at: 0, effectiveRange: nil))
            cell.answerLabel.font = UIFont(name: cell.answerLabel.font.fontName, size: SCUtils.ComponentSize.LABEL_FONT17)
            cell.actionButton.isHidden = false
            cell.actionButton.isEnabled = true
            cell.infoDelegate = self
            cell.actionButton.tag = 4
            return cell
        } else if indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "visioncell") as! SCExtendedCell
            cell.answerLabel.attributedText = NSAttributedString(string: "Not blind", attributes: cell.answerLabel.attributedText!.attributes(at: 0, effectiveRange: nil))
            cell.answerLabel.font = UIFont(name: cell.answerLabel.font.fontName, size: SCUtils.ComponentSize.LABEL_FONT17)
            cell.actionButton.isHidden = false
            cell.actionButton.isEnabled = true
            cell.infoDelegate = self
            cell.actionButton.tag = 5
            return cell
        }
        return defaultCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "togcsfinalscore", sender: self)
    }
    
}

