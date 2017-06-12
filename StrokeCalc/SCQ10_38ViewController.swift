//
//  SCQ10_38ViewController.swift
//  StrokeCalc
//
//  Created by Mobile on 11/03/2017.
//  Copyright © 2017 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCQ10_38ViewController: SCBaseViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var nextButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var nextButton: SCAnswerButton!
    
    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
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

    @IBAction func nextButtonTouchUp(_ sender: SCAnswerButton) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SCQ10ReadWordsViewController") as! SCQ10ReadWordsViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    // MARK: - Custom Methods
    
    func initUI() {
        self.titleLabel.attributedText = NSMutableAttributedString().boldHeader(text: "10. Speech clarity")
        self.descriptionLabel.attributedText = NSMutableAttributedString().normal(text: "Ask the patient ").orangeBold(text: "TO READ").normal(text: " the words in the following screen.")
        
        self.nextButtonHeightConstraint.constant = SCUtils.shared.sizeFor(value: 65)
    }
}
