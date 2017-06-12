//
//  SCPhotoViewController.swift
//  StrokeCalc
//
//  Created by Mobile Guru on 10/26/16.
//  Copyright © 2016 Mobile Guru. All rights reserved.
//

import UIKit
import AVFoundation

class SCPhotoViewController: UIViewController {

    @IBOutlet weak var cameraView: UIView!
    
    var captureDevice : AVCaptureDevice?
    let captureSession = AVCaptureSession()
    var previewLayer : AVCaptureVideoPreviewLayer?
    let screenWidth = UIScreen.main.bounds.size.width
    
    override func viewDidLoad() {
        super.viewDidLoad()
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        
        if let devices = AVCaptureDevice.devices() {
            // Loop through all the capture devices on this phone
            for device in devices {
                // Make sure this particular device supports video
                if ((device as! AVCaptureDevice).hasMediaType(AVMediaTypeVideo)) {
                    // Finally check the position and confirm we've got the back camera
                    if((device as! AVCaptureDevice).position == AVCaptureDevicePosition.back) {
                        captureDevice = device as? AVCaptureDevice
                    }
                }
            }
        }
        
        if captureDevice != nil {
            beginSession()
        }
        
        
    }
    
    func beginSession() {
        let err : NSError? = nil
        guard let videoInput = try? AVCaptureDeviceInput(device: captureDevice) else {
            print("No device for input")
            return
        }
        
        captureSession.addInput(videoInput)
        
        if err != nil {
            print("error: \(err?.localizedDescription)")
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.cameraView.layer.addSublayer(previewLayer!)
        previewLayer?.frame = self.view.layer.frame
        captureSession.startRunning()
    }
    
    
    
    
    func focusTo(value : Float) {
        guard let device = captureDevice else {
            print("Error")
            return
        }
        
        do {
            try device.lockForConfiguration()
        } catch  {
            print("error")
        }
        
        device.setFocusModeLockedWithLensPosition(value, completionHandler: { (time) -> Void in
            //
        })
        device.unlockForConfiguration()
    
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchPercent = touch.location(in: self.view).x / screenWidth
            focusTo(value: Float(touchPercent))
        }
        super.touchesBegan(touches, with: event)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let touchPercent = touch.location(in: self.view).x / screenWidth
            focusTo(value: Float(touchPercent))
        }
    }
    
    func configureDevice() {
        if let device = captureDevice {
            do {
                try device.lockForConfiguration()
                device.focusMode = .locked
                device.unlockForConfiguration()
            } catch {
                print("error")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func openPhotos(_ sender: AnyObject) {
    }

    @IBAction func shotPhoto(_ sender: AnyObject) {
        
    }
    @IBAction func closeController(_ sender: AnyObject) {
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
