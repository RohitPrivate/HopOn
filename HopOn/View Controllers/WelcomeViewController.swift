//
//  WelcomeViewController.swift
//  HopOn
//
//  Created by ROHIT SARAF on 04/11/16.
//  Copyright © 2016 AppLives. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController, MRCountryPickerDelegate {
    
    var isBackActionRequested : Bool! = false
    var countryCodesView : UIView!
    var countryWithCode : String!
    var countryButton : UIButton!
    var selectedCountryCode : String!
    

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
            listScrollViewLeadingConstraint.constant = 20
            listScrollViewTrailingConstraint.constant = 20
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
    
    func createCountryCodeSelectionView() {
        if countryCodesView == nil {
            let xPadding : CGFloat = 30
            let yPadding : CGFloat = 60
            let width = (self.view.frame.size.width - (2 * xPadding))
            let height = (self.view.frame.size.height - (2 * yPadding))
            let okButtonHeight = 35
            
            countryCodesView = UIView.init(frame: CGRect(x : 0, y : 0, width : self.view.frame.size.width, height : self.view.frame.size.height))
            countryCodesView.backgroundColor = UIColor.clear
            
            let tapGestureRecognizer : UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: #selector(LoginViewController.dismissCodePickerView(sender:)))
            countryCodesView.addGestureRecognizer(tapGestureRecognizer)
            
            let countryPickerView : MRCountryPicker = MRCountryPicker.init(frame: CGRect(x : xPadding, y : yPadding, width : width, height : height - CGFloat(okButtonHeight)))
            countryPickerView.countryPickerDelegate = self
            countryPickerView.backgroundColor = UIColor.white
            countryPickerView.showPhoneNumbers = true
            countryPickerView.setCountry("CA")
            countryPickerView.backgroundColor = UIColor.white
            countryCodesView.addSubview(countryPickerView)
            
            let okView : UIButton = UIButton.init(frame: CGRect(x : xPadding, y : countryPickerView.frame.size.height, width : width, height : CGFloat(okButtonHeight)))
            okView.setTitle("OK", for: UIControlState.normal)
            okView.setTitleColor(UIColor.black, for: UIControlState.normal)
            
            okView.addTarget(self, action: #selector(WelcomeViewController.dismissCodePickerView(sender:)), for: UIControlEvents.touchUpInside)
            countryCodesView.addSubview(okView)
            countryCodesView.bringSubview(toFront: okView)
            
            self.view.addSubview(countryCodesView)
        } else {
            self.view.addSubview(countryCodesView)
        }
    }
    
    func dismissCodePickerView(sender : UITapGestureRecognizer) {
        countryCodesView.removeFromSuperview()
    }
    
    //MRCountryPicker Delegate
    func countryPhoneCodePicker(_ picker: MRCountryPicker, didSelectCountryWithName name: String, countryCode: String, phoneCode: String, flag: UIImage) {
        var countryWithCode : String = String(format : phoneCode + "|" + countryCode)
        countryWithCode = countryWithCode.replacingOccurrences(of: "+", with: "")
        countryButton.setTitle(countryWithCode, for: UIControlState.normal)
        selectedCountryCode = phoneCode
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

