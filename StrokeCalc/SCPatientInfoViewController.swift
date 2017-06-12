//
//  SCPatientInfoViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 10/25/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCPatientInfoViewController: SCBaseViewController, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, SCCameraControlViewDelegate {
    var flash : UIImagePickerControllerCameraFlashMode?
    let imagePicker = UIImagePickerController()
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var documentPhoto: UIImageView!
    
    var isGenderSelected = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nextButton.setBackgroundColor(color: UIColor.init(red: 208, green: 225, blue: 236, transperancy: 1.0), forState: .highlighted)
        navigationController?.isNavigationBarHidden = false
        self.documentPhoto.isHidden = true
    }
    
    @IBAction func makePhoto(_ sender: AnyObject) {
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            imagePicker.showsCameraControls = false
            imagePicker.modalPresentationStyle = .fullScreen
            let controlView = SCCameraControlView.loadFromNibNamed(nibNamed: "SCPhotoControlView") as! SCCameraControlView
            controlView.delegate = self
            imagePicker.cameraOverlayView = controlView
            
            self.flash = imagePicker.cameraFlashMode
            self.present(imagePicker, animated: true, completion: nil)
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "gendercell", for: indexPath) as! SCGenderTableViewCell
        if indexPath.row == 0 {
            cell.genderLabel.text = "FEMALE"
            cell.checkmark.image = UIImage(named: "checkmark")
            cell.checkmark.isHidden = true
            cell.accessoryType = .none
        } else if indexPath.row == 1 {
            cell.checkmark.image = UIImage(named: "checkmark")
            cell.checkmark.isHidden = true
            cell.genderLabel.text = "MALE"
            cell.accessoryType = .none
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            let cell = tableView.cellForRow(at: indexPath) as! SCGenderTableViewCell
        cell.checkmark.isHidden = false
        if !isGenderSelected {
            self.isGenderSelected = true
            let labelTitle = NSMutableAttributedString(attributedString: self.nextButton.attributedTitle(for: .normal)!)
            labelTitle.mutableString.setString("NEXT")
            self.nextButton.setAttributedTitle(labelTitle, for: .normal)
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! SCGenderTableViewCell
        cell.checkmark.isHidden = true
    }
    
    // MARK: - ImagePickerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let tempImage:UIImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.documentPhoto.image = tempImage
        self.documentPhoto.isHidden = false
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func flashTrigerred() {
        if self.flash == .auto {
            self.flash = .on
            self.imagePicker.cameraFlashMode = self.flash!
        } else if self.flash == .off {
            self.flash = .on
            self.imagePicker.cameraFlashMode = self.flash!
        } else if self.flash == .on {
            self.flash = .off
            self.imagePicker.cameraFlashMode = self.flash!
        }
    }
    
    func close() {
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func photoTaken() {
        imagePicker.takePicture()
    }
    
    func openPhotos() {
        imagePicker.dismiss(animated: false) { 
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                
                self.imagePicker.sourceType = .photoLibrary
                self.imagePicker.delegate = self
                self.imagePicker.modalPresentationStyle = .fullScreen
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            
        }
    }
    
    
    @IBAction func toNIHSS(_ sender: AnyObject) {
        performSegue(withIdentifier: "tonihss", sender: self)
    }
}
