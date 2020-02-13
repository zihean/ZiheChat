//
//  ViewController.swift
//  ZiheChat
//
//  Created by 安子和 on 2020/2/10.
//  Copyright © 2020 安子和. All rights reserved.
//

import UIKit
import LeanCloud
import SVProgressHUD

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //if let _ = LCApplication.default.currentUser{
         //   self.performSegue(withIdentifier: "welcomeToChat", sender: self)
        //}
        SVProgressHUD.setMaximumDismissTimeInterval(5)
        SVProgressHUD.setMinimumDismissTimeInterval(3)
        SVProgressHUD.show()
    }


}

