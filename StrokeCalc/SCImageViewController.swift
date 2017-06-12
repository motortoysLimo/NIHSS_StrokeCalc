//
//  SCImageViewController.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 10/03/2017.
//  Copyright © 2017 Mobile Guru. All rights reserved.
//

import UIKit

@objc protocol SCImageViewProtocol {
    @objc optional func imageViewDissmissed()
}

class SCImageViewController: UIViewController, SCAlertServiceProtocol, SCImageViewProtocol {
    
    // MARK: - Properties
    
    @IBOutlet weak var imageView: UIImageView!
    var delegate: SCImageViewProtocol?
    
    // MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showInstructionAlert()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.all
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func closeTouchUp(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.delegate?.imageViewDissmissed!()
        }
    }
    
    @IBAction func imageViewTapGesture(_ sender: UITapGestureRecognizer) {
//        self.dismiss(animated: true, completion: nil)
//        self.dismiss(animated: true) {
//            self.delegate?.imageViewDissmissed!()
//        }
    }
    
    func showInstructionAlert() {
        let alertController = self.storyboard?.instantiateViewController(withIdentifier: "alertcontroller") as! SCAlertViewController
        alertController.alertWith(title: NSMutableAttributedString(string: ""), message: NSMutableAttributedString().orangeBold(text: "Please turn the iPhone around and show the screen to the patient"), okButtonTitle: NSMutableAttributedString().blueButton(text: "Got it!", size: 20), isPhone: true)
        alertController.delegate = self
        alertController.modalTransitionStyle = .crossDissolve
        alertController.modalPresentationStyle = .overCurrentContext
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - SCAlertServiceProtocol
    
    func okButtonPressed(sender: UIButton) {
        
    }

}
