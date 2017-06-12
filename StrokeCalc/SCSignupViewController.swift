//
//  SCSignupViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 10/20/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//



import UIKit

class SCSignupViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate {
    
    var regexes = [AnyObject]()
    var textFields = [AnyObject]()
    
    @IBOutlet weak var termsButton: UIButton!
    @IBOutlet weak var studentButtonConstraintVertical: NSLayoutConstraint!
    @IBOutlet weak var fieldSeparator: UIView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var startTheTrial: UIButton!
    @IBOutlet weak var termsLabel: UILabel!
    @IBOutlet weak var buyNowButton: UIButton!
    @IBOutlet weak var studentButton: UIButton!
    @IBOutlet weak var pickerBottomDistanceConstraint: NSLayoutConstraint!
    @IBOutlet weak var providerTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var firstNameTextField: UITextField!
    
    let providerList = ["Please choose","Emergency Med Attending",
        "Emergency Med Resident/Fellow",
        "Neurology Attending",
        "Neurology Resident/Fellow",
        "Other Attending",
        "Other Resident/Fellow",
        "Nurse",
        "Nurse Practitioner",
        "Physician Assistant",
        "Therapist (PT/OT/Speech)",
        "Paramedic",
        "EMT - Hospital",
        "EMT - Ambulance",
        "Certified Medical Assistant",
        "Certified Nursing Assistant"]
    
    @IBOutlet weak var provierPicker: UIPickerView!
    

    @IBOutlet weak var pickerLeadingConstraint: NSLayoutConstraint!
    var pickerFrame : CGRect?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        provierPicker.isHidden = true
        let color = UIColor.init(red: 21, green: 83, blue: 132, transperancy: 0.7)
        UIPickerView.appearance().backgroundColor = color
        navigationController?.isNavigationBarHidden = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.isNavigationBarHidden = true
        self.pickerFrame = self.provierPicker.frame
        hidePickerWithAnimation()
        if SCUtils.DeviceType.IS_IPHONE_5 {
            self.studentButtonConstraintVertical.constant = 5
            self.pickerLeadingConstraint.constant = -16
        } else if SCUtils.DeviceType.IS_IPHONE_6 {
            self.studentButtonConstraintVertical.constant = 35
            self.pickerLeadingConstraint.constant = -16
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "envirnonment" {
            
        } else if segue.identifier == "studentform" {
            var studentController = segue.destination as! SCStudentFormViewController
            if let text = firstNameTextField.text, !text.isEmpty
            {
                studentController.transitedFirstName = text
            }
            if let text = lastNameTextField.text, !text.isEmpty
            {
                studentController.transitedLastName = text
            }
            if let text = emailTextField.text, !text.isEmpty
            {
                studentController.transitedEmail = text
            }
        }
    }
    

    @IBAction func startTrial(_ sender: AnyObject) {
        if isAllFieldsValid() {
            performSegue(withIdentifier: "envirnonment", sender: self)
        } else {
            print("Invalid fields")
        }
    }
    
    @IBAction func buyNow(_ sender: AnyObject) {
            performSegue(withIdentifier: "buynow", sender: self)
    }
    

    @IBAction func openStudentSignup(_ sender: AnyObject) {
        performSegue(withIdentifier: "studentform", sender: self)
    }
    
    @IBAction func openTerms(_ sender: AnyObject) {
        performSegue(withIdentifier: "showterms", sender: self)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 104 {
            self.showPickerWithAnimation()
            return false
        } else {
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 104 {
            showPickerWithAnimation()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.tag == 104 {
            self.provierPicker.isHidden = true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return self.view.frame.size.width
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 20.0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return providerList.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let view = pickerView.view(forRow: row, forComponent: component) as! SCPickerRowView
        self.providerTextField.text = view.rowLabel.text
        view.backgroundColor = UIColor.init(red: 63, green: 180, blue: 251, transperancy: 1.0)
        hidePickerWithAnimation()
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if let view = view as? SCPickerRowView {
            return view
        } else {
            let newRow : SCPickerRowView = UIView.fromNib()
            newRow.rowLabel.text = self.providerList[row]
            newRow.backgroundColor = UIColor.clear
            return newRow
            
        }
    }

    
    
    
    func hidePickerWithAnimation() {
        self.pickerBottomDistanceConstraint.constant = -self.provierPicker.frame.size.height
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
                self.termsButton.alpha = 1.0
                self.startTheTrial.alpha = 1.0
                self.buyNowButton.alpha = 1.0
                self.studentButton.alpha = 1.0
                self.termsLabel.alpha = 1.0
                self.providerTextField.alpha = 1.0
            self.borderView.alpha = 1.0
            self.fieldSeparator.alpha = 1.0
            self.termsButton.isEnabled = true
            self.emailTextField.isEnabled = true
            self.firstNameTextField.isEnabled = true
            self.lastNameTextField.isEnabled = true
            }, completion: { (isEnded) in
                //self.provierPicker.isHidden = true
        })
    }
    
    func showPickerWithAnimation() {
        self.pickerBottomDistanceConstraint.constant = 0
        self.provierPicker.isHidden = false
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            self.termsButton.alpha = 0.0
            self.startTheTrial.alpha = 0.0
            self.buyNowButton.alpha = 0.0
            self.studentButton.alpha = 0.0
            self.termsLabel.alpha = 0.0
            self.providerTextField.alpha = 0.0
            self.borderView.alpha = 0.0
            self.fieldSeparator.alpha = 0.0
            
            self.termsButton.isEnabled = false
            self.emailTextField.isEnabled = false
            self.firstNameTextField.isEnabled = false
            self.lastNameTextField.isEnabled = false
            
            
            }, completion: { (isEnded) in
        })
    }
    
    func isAllFieldsValid() -> Bool {
        let isValidName = self.firstNameTextField.text?.isName()
        let isValidLastName = self.lastNameTextField.text?.isName()
        let isValidEmail = self.emailTextField.text?.isEmail()
        let isValidProvider = !((self.providerTextField.text?.isEmpty)!)
        
        
        if !(isValidName)! {
            let alert = UIAlertController(title: "Error", message: "Please input valid name", preferredStyle: .alert)
            let action  = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        } else if !(isValidLastName)! {
            let alert = UIAlertController(title: "Error", message: "Please input valid last name", preferredStyle: .alert)
            let action  = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        } else if !(isValidEmail)! {
            let alert = UIAlertController(title: "Error", message: "Please input valid email", preferredStyle: .alert)
            let action  = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        } else if !(isValidProvider) {
            let alert = UIAlertController(title: "Error", message: "Please pick a valid provider", preferredStyle: .alert)
            let action  = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
        return (isValidName! && isValidLastName! && isValidEmail! && isValidProvider)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
        if let touch = touches.first {
           if (touch.view != self.provierPicker) {
            self.hidePickerWithAnimation()
            }
        }
    }
    
    func setupUnderlineColorForButtons() {
        let studentString = NSMutableAttributedString(attributedString: self.studentButton.attributedTitle(for: .normal)!)
        studentString.addAttribute(NSUnderlineColorAttributeName, value: UIColor.lightGray, range: NSMakeRange(0, studentString.length))
        self.studentButton.setAttributedTitle(studentString, for: .normal)
        
        let termsString = NSMutableAttributedString(attributedString: self.termsButton.attributedTitle(for: .normal)!)
        termsString.addAttribute(NSUnderlineColorAttributeName, value: UIColor.lightGray, range: NSMakeRange(0, termsString.length))
        self.termsButton.setAttributedTitle(termsString, for: .normal)
    }
    
    
}


