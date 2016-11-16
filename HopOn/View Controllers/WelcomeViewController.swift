//
//  WelcomeViewController.swift
//  HopOn
//
//  Created by ROHIT SARAF on 04/11/16.
//  Copyright © 2016 AppLives. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    var isBackActionRequested : Bool! = false

    @IBOutlet weak var welcomeToHopOnLabel: UILabel!
    @IBOutlet weak var splitCostLabel: UILabel!
    @IBOutlet weak var greenCommuteLabel: UILabel!
    @IBOutlet weak var trafficLabel: UILabel!
    @IBOutlet weak var driverLabel: UILabel!
    @IBOutlet weak var driverView: UIView!
    @IBOutlet weak var listScrollView: UIScrollView!
    
    @IBOutlet weak var welcomeIconTopLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var welcomeToHopOnLabelConstraint: NSLayoutConstraint!
    @IBOutlet weak var listScrollViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var listScrollViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomLayoutConstraintToNextButton: NSLayoutConstraint!
    @IBOutlet weak var listScrollViewTopConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.adjustFontSize()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)

        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        if (AppConstants.deviceType == AppConstants.DeviceType.iPhone7PlusType) {
            welcomeIconTopLayoutConstraint.constant = 60
            welcomeToHopOnLabelConstraint.constant = 40
            listScrollViewLeadingConstraint.constant = 30
            listScrollViewTrailingConstraint.constant = 30
            bottomLayoutConstraintToNextButton.constant = 30
            listScrollViewTopConstraint.constant = 20
        } else if (AppConstants.deviceType == AppConstants.DeviceType.iPhone7Type) {
            welcomeIconTopLayoutConstraint.constant = 40
            welcomeToHopOnLabelConstraint.constant = 30
            listScrollViewLeadingConstraint.constant = 25
            listScrollViewTrailingConstraint.constant = 25
            bottomLayoutConstraintToNextButton.constant = 25
            listScrollViewTopConstraint.constant = 10
        } else if (AppConstants.deviceType == AppConstants.DeviceType.iPhone5Type) {
            welcomeIconTopLayoutConstraint.constant = 40
            welcomeToHopOnLabelConstraint.constant = 20
            listScrollViewLeadingConstraint.constant = 20
            listScrollViewTrailingConstraint.constant = 20
            bottomLayoutConstraintToNextButton.constant = 20
            listScrollViewTopConstraint.constant = 10
        }

    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.adjustScrollContentHeight()
    }
    
    func adjustFontSize() {
        let fontName : String = AppConstants.Font.CaviarDreamsRegular.rawValue
        var labelFont : UIFont! = UIFont(name: fontName, size: 15.0)
        var headerFont : UIFont! = UIFont(name: fontName, size: 24.0)
        
        switch Helper.sharedInstance.deviceType() {
        case AppConstants.DeviceType.iPhone4Type:
            labelFont = UIFont(name: fontName, size: 14.0)
            headerFont = UIFont(name: fontName, size: 24.0)
            break
        case AppConstants.DeviceType.iPhone5Type:
            labelFont = UIFont(name: fontName, size: 14.0)
            headerFont = UIFont(name: fontName, size: 24.0)
            break
        case AppConstants.DeviceType.iPhone7Type:
            labelFont = UIFont(name: fontName, size: 18.0)
            headerFont = UIFont(name: fontName, size: 26.0)
            break
        case AppConstants.DeviceType.iPhone7PlusType:
            labelFont = UIFont(name: fontName, size: 18.0)
            headerFont = UIFont(name: fontName, size: 30.0)
            break
        default :
            break
        }
        
        splitCostLabel?.font = labelFont
        greenCommuteLabel?.font = labelFont
        trafficLabel?.font = labelFont
        driverLabel?.font = labelFont
        
        welcomeToHopOnLabel?.font = headerFont
    }
    
    func adjustScrollContentHeight() {
        let contentheight : CGFloat = (driverView?.frame.origin.y)! + (driverView?.frame.size.height)!
        if contentheight > listScrollView.contentSize.height {
            listScrollView.contentSize.height = contentheight
        }
    }
    
    @IBAction func backButtonAction(_ sender: Any?) {
        if !isBackActionRequested! {
            isBackActionRequested = true
            _ = self.navigationController?.popViewController(animated: true)
            isBackActionRequested = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

