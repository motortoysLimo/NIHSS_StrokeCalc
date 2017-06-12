//
//  SCStudentFormViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 10/20/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCStudentFormViewController: UIViewController,UITextFieldDelegate, UIPickerViewDelegate,UIPickerViewDataSource {
    
    @IBOutlet weak var allFieldsLabel: UILabel!
    var transitedFirstName : String?
    var transitedLastName : String?
    var transitedEmail : String?
    
    @IBOutlet weak var yearPicker: UIPickerView!
    @IBOutlet weak var degreSeparator: UIView!

    @IBOutlet weak var dobVerticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var dobPicker: UIDatePicker!
    @IBOutlet weak var schoolPickerVerticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var schoolPicker: UIPickerView!
    @IBOutlet weak var schoolSeparator: UIView!
    @IBOutlet weak var yearSeaprator: UIView!
    @IBOutlet weak var degreePickerVerticalConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    
    @IBOutlet weak var degreeField: UITextField!
    @IBOutlet weak var graduationYearField: UITextField!
    @IBOutlet weak var schoolField: UITextField!
    @IBOutlet weak var dobField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var degreePicker: UIPickerView!
    @IBOutlet weak var firstNameContraintsVertical: NSLayoutConstraint!
    
    @IBOutlet weak var lastNameConstraintVertical: NSLayoutConstraint!
    @IBOutlet weak var emailConstraintVertical: NSLayoutConstraint!
    @IBOutlet weak var dobConstraintVertical: NSLayoutConstraint!
    @IBOutlet weak var schoolNameConstraintVertical: NSLayoutConstraint!
    @IBOutlet weak var degreeConstraintVertical: NSLayoutConstraint!
    
    @IBOutlet weak var yearPickerVerticalConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var verifyButton: UIButton!
    var degreeList = [String]()
    var schoolList = [String]()
    
    let yearList = ["2016",
                    "2017",
                    "2018",
                    "2019",
                    "2020"]
    //MARK: VC LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let color = UIColor.init(red: 21, green: 83, blue: 132, transperancy: 0.7)
        
        dobPicker.backgroundColor = color
        dobPicker.setValue(UIColor.white, forKeyPath: "textColor")
        dobPicker.setValue(0.7, forKeyPath: "alpha")
        
        yearPicker.setValue(UIColor.white, forKeyPath: "textColor")
        
        degreeList = ["MD/DO",
            "DDS/DMD",
            "RN/NP",
            "PharmD",
            "DC",
            "DPM",
            "PA",
            "PT/OT/Speech",
            "Paramedic/EMT",
            "CMA/CNA"]
        schoolList = ["Harvard medical school",
        "Berkley"]
        self.degreePickerVerticalConstraint.constant = -self.degreePicker.frame.size.height
        self.schoolPickerVerticalConstraint.constant = -self.schoolPicker.frame.size.height
        self.dobVerticalConstraint.constant = -self.dobPicker.frame.size.height
        self.yearPickerVerticalConstraint.constant = -self.yearPicker.frame.size.height
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let transitedNameText = self.transitedFirstName {
            self.firstNameField.text = transitedNameText
        }
        
        if let transitedLastNameText = self.transitedLastName {
            self.lastNameField.text = transitedLastNameText
        }
        
        if let transitedEmailText = self.transitedEmail {
            self.emailField.text = transitedEmailText
        }
        
        if (SCUtils.DeviceType.IS_IPHONE_6) {
        
        } else if (SCUtils.DeviceType.IS_IPHONE_5) {
            
            self.firstNameContraintsVertical.constant = 20
            self.lastNameConstraintVertical.constant = 20
            self.emailConstraintVertical.constant = 20
            self.dobConstraintVertical.constant = 20
            self.schoolNameConstraintVertical.constant = 20
            self.degreeConstraintVertical.constant = 20
        }
        self.updateViewConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: Actions
    @IBAction func backButtonTapped(_ sender: UIButton) {
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func dobChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        let selectedDate = dateFormatter.string(from: sender.date)
        self.dobField.text = selectedDate
    }

    @IBAction func verifyEnrollmentStatus(_ sender: AnyObject) {
//        if isAllFieldsValid(){
            self.performSegue(withIdentifier: "envirnonmentStudent", sender: self)
//        }
    }
    
    //MARK: - TextField Delegate
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField.tag == 104 {
            self.showPickerWithAnimation(self.degreePicker,datePicker: nil)
            return false
        } else if textField.tag == 103 {
            return true
        } else if textField.tag == 105 {
            self.showPickerWithAnimation(nil, datePicker: self.dobPicker)
            return false
        } else if textField.tag == 101 {
            self.showPickerWithAnimation(self.yearPicker, datePicker: nil)
            return false
        } else {
            return true
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
    //MARK: - PickerView Delegate
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return self.view.frame.size.width
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 20.0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == self.degreePicker {
            return self.degreeList.count
        } else if pickerView == self.schoolPicker {
            return self.schoolList.count
        } else if pickerView == self.yearPicker {
            return self.yearList.count
        } else {
            return 0
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let pickerRow = pickerView.view(forRow: row, forComponent: component) as! SCPickerRowView
        if pickerView == degreePicker {
          self.degreeField.text = pickerRow.rowLabel.text
        } else if pickerView == self.schoolPicker {
            self.schoolField.text = pickerRow.rowLabel.text
        } else if pickerView == self.yearPicker {
            self.graduationYearField.text = pickerRow.rowLabel.text
        }
        
        let view = pickerView.view(forRow: row, forComponent: component) as! SCPickerRowView
        view.backgroundColor = UIColor.init(red: 63, green: 180, blue: 251, transperancy: 1.0)
        self.hidePickerWithAnimation(pickerView,datePicker: nil)
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        if let view = view as? SCPickerRowView {
            return view
        } else {
            let newRow : SCPickerRowView = UIView.fromNib()
            
            if pickerView == self.degreePicker {
                newRow.rowLabel.text = self.degreeList[row]
            } else if pickerView == self.schoolPicker {
                newRow.rowLabel.text = self.schoolList[row]
            } else if pickerView == yearPicker {
                newRow.rowLabel.text = self.yearList[row]
            }
            
            return newRow
            
        }
        
    }
    
    
    //MARK: Animation
    func hidePickerWithAnimation(_ pickerView: UIPickerView?, datePicker : UIDatePicker?) {
        
        self.dobVerticalConstraint.constant = -self.dobPicker.frame.size.height
        if pickerView != nil {
            self.degreePickerVerticalConstraint.constant = -pickerView!.frame.size.height
            self.schoolPickerVerticalConstraint.constant = -pickerView!.frame.size.height
            self.yearPickerVerticalConstraint.constant = -self.yearPicker.frame.size.height
        }
        
        
        self.updateViewConstraints()
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            self.updateViewConstraints()
            self.verifyButton.alpha = 1.0
            self.graduationYearField.alpha = 1.0
            self.degreeField.alpha = 1.0
            self.schoolField.alpha = 1.0
            self.allFieldsLabel.alpha = 1.0
            
            self.graduationYearField.isEnabled = true
            self.degreeField.isEnabled = true
            self.schoolField.isEnabled = true
            self.verifyButton.isEnabled = true
            self.firstNameField.isEnabled = true
            self.lastNameField.isEnabled = true
            self.emailField.isEnabled   = true
            self.dobField.isEnabled = true
            
            self.schoolSeparator.alpha = 1.0
            self.degreSeparator.alpha = 1.0
            self.yearSeaprator.alpha = 1.0
            
        }, completion: { (isEnded) in
            self.updateViewConstraints()
            pickerView?.isHidden = true
            print("Picker hiden")
        })
    }
    
    func showPickerWithAnimation(_ pickerView: UIPickerView?, datePicker : UIDatePicker?) {
        
        if datePicker == self.dobPicker {
            self.dobVerticalConstraint.constant = 0
        } else if datePicker == self.dobPicker {
//            self.schoolPickerVerticalConstraint.constant = 0
        }
        
        if pickerView == self.degreePicker {
            self.degreePickerVerticalConstraint.constant = 0
        } else if pickerView == self.schoolPicker {
            self.schoolPickerVerticalConstraint.constant = 0
        } else if pickerView == self.yearPicker {
            self.yearPickerVerticalConstraint.constant = 0
        }
        
        
        
        if (pickerView != nil ) {
            pickerView!.isHidden = false
        }
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
            self.verifyButton.alpha = 0.0
            self.graduationYearField.alpha = 0.0
            self.degreeField.alpha = 0.0
            self.schoolField.alpha = 0.0
            self.allFieldsLabel.alpha = 0.0
            
            self.graduationYearField.isEnabled = false
            self.degreeField.isEnabled = false
            self.schoolField.isEnabled = false
            self.verifyButton.isEnabled = false
            self.firstNameField.isEnabled = false
            self.lastNameField.isEnabled = false
            self.emailField.isEnabled   = false
            self.dobField.isEnabled = false
            
            self.schoolSeparator.alpha = 0.0
            self.degreSeparator.alpha = 0.0
            self.yearSeaprator.alpha = 0.0
            
        }, completion: { (isEnded) in
            
        })
    }
    // MARK:Validation
    
    func isAllFieldsValid() -> Bool {
        let isValidName = self.firstNameField.text?.isName()
        let isValidLastName = self.lastNameField.text?.isName()
        let isValidEmail = self.emailField.text?.isEmail()
        let isValidDegree = !((self.degreeField.text?.isEmpty)!)
        let isValidGraduateYear = !((self.graduationYearField.text?.isEmpty)!)
        let isValidDOB = !((self.dobField.text?.isEmpty)!)
        let isValidSchool = self.schoolField.text?.isSchool()
        
        
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
        } else if !(isValidDegree) {
            let alert = UIAlertController(title: "Error", message: "Please pick a valid degree", preferredStyle: .alert)
            let action  = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        } else if !(isValidGraduateYear){
            let alert = UIAlertController(title: "Error", message: "Please pick a valid graduate year", preferredStyle: .alert)
            let action  = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        } else if !(isValidDOB){
            let alert = UIAlertController(title: "Error", message: "Please pick a valid date of birth", preferredStyle: .alert)
            let action  = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        } else if !(isValidSchool)!{
            let alert = UIAlertController(title: "Error", message: "Please enter a valid school", preferredStyle: .alert)
            let action  = UIAlertAction(title: "OK", style: .default, handler: { (action) in
                self.dismiss(animated: true, completion: nil)
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
        }
        
        return (isValidName! && isValidLastName! && isValidEmail! && isValidDegree && isValidGraduateYear && isValidDOB && isValidSchool!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
        if let touch = touches.first {
            if ((touch.view != self.degreePicker)) {
                self.hidePickerWithAnimation(self.degreePicker,datePicker: nil)
                self.hidePickerWithAnimation(self.schoolPicker,datePicker: nil)
                self.hidePickerWithAnimation(nil,datePicker: self.dobPicker)
                self.hidePickerWithAnimation(yearPicker, datePicker: nil)
            }
        }
    }
}

