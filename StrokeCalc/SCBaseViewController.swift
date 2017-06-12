//
//  SCBaseViewController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 11/4/16.
//  Copyright © 2016 Ilya Vlasov. All rights reserved.
//

import UIKit

class SCBaseViewController: UIViewController {
    
    let testScoreService = SSCTestScoreService()
    var testScoreServiceSaved = SSCTestScoreService()
    
    var infoHeader : String?
    var infoDetail : NSMutableAttributedString?
    var infoImage : UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
    }
    
    func setupNavBar() {
        let image = UIImage(named: "title")
        let rightButtonImage = UIImage(named: "SA_logo_small")
        self.navigationItem.titleView = UIImageView(image: image)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightButtonImage, style: .plain, target: self, action: #selector(self.logoTapped))
    }
    
    func logoTapped() {
        _ = self.navigationController?.popToRootViewController(animated: true)
//        let lastScreenController = self.storyboard!.instantiateViewController(withIdentifier: "lastscreen") as! GCSMotorResponseViewController
//        self.navigationController?.pushViewController(lastScreenController, animated: true  )
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    override var shouldAutorotate: Bool {
        return true
    }

}
