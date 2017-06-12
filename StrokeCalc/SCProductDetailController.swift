//
//  SCProductDetailController.swift
//  StrokeCalc
//
//  Created by Ilya Vlasov on 11/8/16.
//  Copyright © 2016 Mobile Guru. All rights reserved.
//

import UIKit

class SCProductDetailController: UIViewController {

    @IBOutlet weak var detail: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.hidesBackButton = false
        configureView()
    }
    
    var image: UIImage? {
        didSet {
            configureView()
        }
    }

    func configureView() {
        detail?.image = image
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
