//
//  Helper.swift
//  HopOn
//
//  Created by ROHIT SARAF on 11/11/16.
//  Copyright © 2016 AppLives. All rights reserved.
//

import UIKit

class Helper: NSObject {
    
    static let sharedInstance = Helper()
    var loaderView : UIView? = nil
    
    // MARK: LOADER VIEW
    func loaderView(_ baseView : UIView?) -> UIView? {
        if baseView == nil {
            return nil
        }
        if loaderView == nil {
            loaderView = UIView.init(frame: (baseView?.bounds)!)
            loaderView?.backgroundColor = UIColor.clear
        } else {
            loaderView?.frame = (baseView?.bounds)!
        }
        loaderView?.alpha = 0.0
        
        let spinnerViewSize : CGSize = CGSize.init(width: 100, height: 100)
        
        let spinnerView : UIView = UIView.init(frame: CGRect (x: (loaderView!.frame.size.width - spinnerViewSize.width ) / 2, y: (loaderView!.frame.size.height - spinnerViewSize.height) / 2 + 48.0, width: spinnerViewSize.width, height: spinnerViewSize.height))
        spinnerView.backgroundColor = UIColor.init(colorLiteralRed: 0/255, green: 0/255, blue: 0/255, alpha: 0.7)
        spinnerView.layer.cornerRadius = spinnerViewSize.width / 8
        
        let spinner : UIActivityIndicatorView = UIActivityIndicatorView.init(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        spinner.isHidden = false
        spinner.center = CGPoint.init(x: spinnerView.frame.size.width / 2, y: spinnerView.frame.size.height / 2)
        spinner.startAnimating()
        
        spinnerView.addSubview(spinner)
        loaderView!.addSubview(spinnerView)
        
        return loaderView!
    }
    
    func fadeInLoaderView(_ baseView : UIView) {
        if loaderView == nil {
            _ = self.loaderView(baseView)
        }
        baseView.addSubview(loaderView!)
        UIView.animate(withDuration: 0.5, animations: {
            self.loaderView?.alpha = 1.0
        })
    }
    
    func fadeOutLoaderView() {
        UIView.animate(withDuration: 0.5, animations: {
            self.loaderView!.alpha = 0.0
        }, completion: { (finished : Bool) in
            self.loaderView?.removeFromSuperview()
            self.loaderView = nil
        })
    }
    
    //MARK: ALERT POP UP
    func popupLabelForCustomAlert(_ alertText:String?, baseView:UIView) -> UILabel? {
        if alertText?.characters.count == 0 || alertText == nil {
            return nil
        }
        
        let popupLabel : UILabel = UILabel()
        popupLabel.backgroundColor = UIColor.darkGray
        popupLabel.textColor = UIColor.white
        popupLabel.text = alertText
        popupLabel.numberOfLines = 0
        popupLabel.clipsToBounds = true
        popupLabel.alpha = 0.0
        popupLabel.textAlignment = .center
        popupLabel.sizeToFit()
        
        var frame : CGRect = popupLabel.frame
        frame.size.width += 20.0
        frame.size.height += 10.0
        frame.origin.x = (baseView.frame.size.width - frame.size.width) / 2
        frame.origin.y = (baseView.frame.size.height - frame.size.height ) / 2
        popupLabel.frame = frame
        
        popupLabel.layer.cornerRadius = popupLabel.frame.size.height / 2
        
        baseView.addSubview(popupLabel)
        
        return popupLabel
    }
    
    func fadeInAlertPopup(_ popup : UIView?) {
        if popup == nil {
            return
        }
        UIView.animate(withDuration: 0.4, animations: {
            popup!.alpha = 1.0
        }, completion: {(finished : Bool) -> Void in
            self.perform(#selector(Helper.fadeOutAlertPopup(_:)), with: popup, afterDelay: 1.0)
        })
    }
    
    func fadeOutAlertPopup(_ popup : UIView?) {
        if popup == nil {
            return
        }
        UIView.animate(withDuration: 0.6, animations: {
            popup!.alpha = 0.0
        }, completion: {(finished : Bool) -> Void in
            popup?.removeFromSuperview()
        })
    }
    
    func deviceType() -> AppConstants.DeviceType {
        
        if AppConstants.deviceType == AppConstants.DeviceType.none {
            let deviceHeight = UIScreen.main.bounds.size.height
            
            if deviceHeight <= 480 {
                AppConstants.deviceType = AppConstants.DeviceType.iPhone4Type
            } else if deviceHeight == 568 {
                AppConstants.deviceType = AppConstants.DeviceType.iPhone5Type
            } else if deviceHeight == 667 {
                AppConstants.deviceType = AppConstants.DeviceType.iPhone7Type
            } else if deviceHeight == 736 {
                AppConstants.deviceType = AppConstants.DeviceType.iPhone7PlusType
            }
        }
        return AppConstants.deviceType
    }
    
    //MARK: Email Validation
    func validateEmail(_ email : String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
    
    func verificationCode() -> String {
        return String(arc4random_uniform(9999))
    }
    
}
