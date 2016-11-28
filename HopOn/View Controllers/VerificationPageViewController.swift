//
//  VerificationPageViewController.swift
//  HopOn
//
//  Created by ROHIT SARAF on 04/11/16.
//  Copyright © 2016 AppLives. All rights reserved.
//

import UIKit

class VerificationPageViewController: WelcomeViewController {
    @IBOutlet weak var sendCodeAgainButton: UIButton!

    @IBOutlet weak var verificationField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let attributedText : NSMutableAttributedString = sendCodeAgainButton.titleLabel?.attributedText as! NSMutableAttributedString
        
        attributedText.beginEditing()
        attributedText.addAttribute(NSFontAttributeName, value: UIFont(name: "CaviarDreams", size: 15) as Any, range: NSMakeRange(0, attributedText.length))
        attributedText.endEditing()
        
        sendCodeAgainButton.setAttributedTitle(attributedText, for: UIControlState.normal)

    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }

    @IBAction func verifyCodeAction(_ sender: Any) {
        if sender is UIButton {
            var showPopup : Bool = false
            var alertString : String = ""
            
            let enteredVerificationCode : String = verificationField.text!
            if enteredVerificationCode.characters.count != 0 {
                let generatedVerificationCode : String = UserDefaults.standard.object(forKey: AppConstants.VERIFICATION_CODE_KEY) as! String
                if enteredVerificationCode == generatedVerificationCode {
                    self.makeUserVerificationApiCall()
                } else {
                    showPopup = true
                    alertString = "Verification code does not match"
                }
            } else {
                showPopup = true
                alertString = "Please enter the verification code"
            }
            if showPopup {
                let popupLabel : UILabel? = Helper.sharedInstance.popupLabelForCustomAlert(("\(alertString)"), baseView: self.view)
                Helper.sharedInstance.fadeInAlertPopup(popupLabel)
            }
        }
    }
    
    func makeUserVerificationApiCall() {
        let userVerificationUrlString : String = String(format : AppConstants.VERIFY_USER_API, (Helper.sharedInstance.currentUser?.id)!)
        Helper.sharedInstance.fadeInLoaderView(self.view)
        ServerClass.sharedInstance.performUserVerificationAction(userVerificationUrlString as String, { (success, message, dataArray) in
            DispatchQueue.main.sync(execute: {
                OperationQueue.main.addOperation {
                    Helper.sharedInstance.fadeOutLoaderView()
                    if success {
                        //Show Home Screen
                        print("success")
                        self.performSegue(withIdentifier: AppConstants.CHOOSE_ONE_PAGE_SEGUE, sender: nil)
                        return
                    } else {
                        Helper.sharedInstance.fadeOutLoaderView()
                        let alertString = message
                        let popupLabel : UILabel? = Helper.sharedInstance.popupLabelForCustomAlert(("\(alertString)"), baseView: self.view)
                        Helper.sharedInstance.fadeInAlertPopup(popupLabel)
                    }
                }
            })
        })
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.backButtonAction(nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func resendVerificationCode(_ sender: Any) {
        _ = self.generateVerificationCode((Helper.sharedInstance.currentUser?.mobile)!)
    }
    
    func generateVerificationCode(_ mobileNumber : String) -> Bool {
        let verificationCode : String? = Helper.sharedInstance.verificationCode();
        print("\(verificationCode)")
        if verificationCode != nil {
            UserDefaults.standard.set(verificationCode, forKey: AppConstants.VERIFICATION_CODE_KEY)
            let sendVerificationURL : String = String(format : AppConstants.SMS_VERIFICATION_API, mobileNumber, verificationCode!)
            print(sendVerificationURL)
            Helper.sharedInstance.fadeInLoaderView(self.view)
            ServerClass.sharedInstance.sendVerificationCodeToUserMobile(sendVerificationURL, mobileNumber, { (success, message) in
                DispatchQueue.main.sync {
                    OperationQueue.main.addOperation {
                        Helper.sharedInstance.fadeOutLoaderView()
                        var alertString = message
                        var popupLabel : UILabel? = Helper.sharedInstance.popupLabelForCustomAlert(("\(alertString)"), baseView: self.view)
                        if success {
                            alertString = "Verification Code sent successfully"
                            popupLabel = Helper.sharedInstance.popupLabelForCustomAlert(("\(alertString)"), baseView: self.view)
                        }
                        Helper.sharedInstance.fadeInAlertPopup(popupLabel)
                    }
                }
            })
            return true
        }
        return false
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
