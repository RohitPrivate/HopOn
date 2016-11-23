//
//  ForgotPasswordViewController.swift
//  HopOn
//
//  Created by ROHIT SARAF on 17/11/16.
//  Copyright © 2016 AppLives. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: WelcomeViewController {

    var scrollViewContentSize : CGSize! = CGSize.zero
    var scrollViewContentOffset : CGPoint! = CGPoint.zero
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var forgotPasswordFillUpBox: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollViewContentOffset = scrollView.contentOffset
        scrollViewContentSize = scrollView.contentSize
        
        NotificationCenter.default.addObserver(self, selector: #selector(ForgotPasswordViewController.keybpoardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ForgotPasswordViewController.keybpoardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keybpoardWillShow(notification : NSNotification) {
        scrollView.isScrollEnabled = true
        
        var  contentSize : CGSize! = scrollView.contentSize;
        
        let keyboardFrame : CGRect = (((notification.userInfo! as NSDictionary).object(forKey: UIKeyboardFrameBeginUserInfoKey) as AnyObject).cgRectValue)!
        contentSize.height = scrollViewContentSize.height + (keyboardFrame.size.height - (self.view.frame.size.height - (scrollView.frame.origin.y + scrollView.frame.size.height)))
        
        UIView.animate(withDuration: 0.2, animations: {
            self.scrollView.contentSize = contentSize
        })

    }
    
    func keybpoardWillHide(notification : NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.scrollView.contentSize = self.scrollViewContentSize!
            self.scrollView.contentOffset = self.scrollViewContentOffset!
        })
    }

    @IBAction func sendAction(_ sender: Any) {
        scrollView.endEditing(true)
        
        let isValidated : Bool = self.validateEmailField()
        if isValidated {
            //Make server call to register the user and proceed
            let registerURLString : String = String(format : AppConstants.FORGOT_PASSWORD_API, emailField.text!)
            
            Helper.sharedInstance.fadeInLoaderView(self.view)
            
            ServerClass.sharedInstance.performForgotPasswordAction(registerURLString as String, { (success, message) in
                DispatchQueue.main.sync(execute: {
                    OperationQueue.main.addOperation {
                        Helper.sharedInstance.fadeOutLoaderView()
                        if success {
                            //Show Home Screen
                            let popupLabel : UILabel? = Helper.sharedInstance.popupLabelForCustomAlert(message, baseView: self.view)
                            Helper.sharedInstance.fadeInAlertPopup(popupLabel)
                            
                            self.perform(#selector(ForgotPasswordViewController.backButtonAction(_:)), with: nil, afterDelay: 1.4)
                            return
                        } else {
                            let alertString = message
                            let popupLabel : UILabel? = Helper.sharedInstance.popupLabelForCustomAlert(("\(alertString)"), baseView: self.view)
                            Helper.sharedInstance.fadeInAlertPopup(popupLabel)
                        }
                    }
                })
            })
        }
    }
    
    func validateEmailField() -> Bool {
        var showPopup : Bool = false
        var alertString : String = ""
        
        let emailString : String = emailField.text!
        
        if emailString.characters.count == 0 {
            showPopup = true
            alertString = "Please enter your email id"
        }
        
        if showPopup == false {
            let isEmailValidated : Bool = Helper.sharedInstance.validateEmail(emailString)
            if !isEmailValidated {
                showPopup = true
                alertString = "Please enter valid email"
            }
        }
        
        if showPopup {
            let popupLabel : UILabel? = Helper.sharedInstance.popupLabelForCustomAlert(alertString, baseView: self.view)!
            Helper.sharedInstance.fadeInAlertPopup(popupLabel)
            
            return false
        } else {
            //Make server call to register the user and proceed
            return true
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.backButtonAction(nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
