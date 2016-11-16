//
//  T&CViewController.swift
//  HopOn
//
//  Created by ROHIT SARAF on 04/11/16.
//  Copyright © 2016 AppLives. All rights reserved.
//

import UIKit

class T_CViewController: WelcomeViewController {
        
    @IBOutlet weak var termsAndConditionTextView: UITextView!
    
    override func viewDidLoad() {
        //super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let fontName : String = AppConstants.Font.CaviarDreamsRegular.rawValue
        var font : UIFont! = UIFont(name: fontName, size: 15.0)
        
        switch Helper.sharedInstance.deviceType() {
        case AppConstants.DeviceType.iPhone4Type:
            font = UIFont(name: fontName, size: 11.0)
            break
        case AppConstants.DeviceType.iPhone5Type:
            font = UIFont(name: fontName, size: 13.0)
            break
        case AppConstants.DeviceType.iPhone7Type:
            font = UIFont(name: fontName, size: 15.0)
            break
        case AppConstants.DeviceType.iPhone7PlusType:
            font = UIFont(name: fontName, size: 16.0)
            break
        default :
            break
        }
        
        termsAndConditionTextView.font = font
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBAction func declineAction(_ sender: Any) {
        self.backButtonAction(nil)
    }
}
