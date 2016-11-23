//
//  LoginViewController.swift
//  HopOn
//
//  Created by ROHIT SARAF on 04/11/16.
//  Copyright © 2016 AppLives. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class LoginViewController: WelcomeViewController {
    
    var shouldStayLoggedIn : Bool! = false

    @IBOutlet weak var loginBoxViewTopLayout: NSLayoutConstraint!
    @IBOutlet weak var loginButtonTopLayooutConstraint: NSLayoutConstraint!
    @IBOutlet weak var loginButtonTopLayoutConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var scrollView: UIScrollView!

    @IBOutlet weak var loginFillUpBox: UIImageView!
    
    @IBOutlet weak var stayLogginginButton: UIButton!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var newToHopOnButton: UIButton!
    
    @IBOutlet weak var emailOrMobileField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if (AppConstants.deviceType == AppConstants.DeviceType.iPhone5Type) {
            stayLogginginButton.titleLabel?.font = UIFont.init(name: AppConstants.Font.CaviarDreamsRegular.rawValue, size: 12)
            forgotPasswordButton.titleLabel?.font = UIFont.init(name: AppConstants.Font.CaviarDreamsRegular.rawValue, size: 12)
        }
        
        let attributedText : NSMutableAttributedString = newToHopOnButton.titleLabel?.attributedText as! NSMutableAttributedString
        
        attributedText.beginEditing()
        attributedText.addAttribute(NSFontAttributeName, value: UIFont(name: "CaviarDreams", size: 15) as Any, range: NSMakeRange(0, attributedText.length))
        attributedText.endEditing()
        
        newToHopOnButton.setAttributedTitle(attributedText, for: UIControlState.normal)
        
        let forgotPasswordattributedText : NSMutableAttributedString = forgotPasswordButton.titleLabel?.attributedText as! NSMutableAttributedString
        
        forgotPasswordattributedText.beginEditing()
        forgotPasswordattributedText.addAttribute(NSFontAttributeName, value: UIFont(name: "CaviarDreams", size: 12) as Any, range: NSMakeRange(0, forgotPasswordattributedText.length))
        forgotPasswordattributedText.endEditing()
        
        forgotPasswordButton.setAttributedTitle(forgotPasswordattributedText, for: UIControlState.normal)
    }
    
    override func viewDidLayoutSubviews() {
        if (AppConstants.deviceType == AppConstants.DeviceType.iPhone5Type || AppConstants.deviceType == AppConstants.DeviceType.iPhone4Type) {
            loginBoxViewTopLayout.constant = 0
            loginButtonTopLayooutConstraint.constant = 20
            
            forgotPasswordButton.frame.size.width += 20
            forgotPasswordButton.frame.origin.x -= 20
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let padding : CGFloat = 10.0
        scrollView.contentSize.height = loginFillUpBox.frame.origin.y + loginFillUpBox.frame.size.height + padding;
    }
    
    //This method is used to start the login process
    @IBAction func loginAction(_ sender: Any) {
        //To dismiss the keyboard
        scrollView.endEditing(true)
        
        let isValidated : Bool = self.validateLoginFields()
        if isValidated {
            //Make server call to register the user and proceed
            let registerURLString : String = String(format : AppConstants.LOGIN_API, emailOrMobileField.text!, passwordField.text!)
            
            Helper.sharedInstance.fadeInLoaderView(self.view)
            
            ServerClass.sharedInstance.performLoginAction(registerURLString as String, { (success, message, dataArray) in
                DispatchQueue.main.sync(execute: {
                    OperationQueue.main.addOperation {
                        if success {
                            //Show Home Screen
                            let userDataObject : UserDetailsDataObject = (dataArray?.lastObject as? UserDetailsDataObject)!
                            Helper.sharedInstance.currentUser = userDataObject
                            let hasVerified : Bool = self.checkVerification()
                            if hasVerified {
                                Helper.sharedInstance.fadeOutLoaderView()
                                self.performSegue(withIdentifier: AppConstants.CHOOSE_ONE_PAGE_SEGUE, sender: nil)
                            } else {
                                let userMobileNumber : String? = userDataObject.mobile
                                if (userMobileNumber == nil || userMobileNumber == "") {
                                    Helper.sharedInstance.fadeOutLoaderView()
                                    self.showAlertWithMessage(message: "Verification Error")
                                } else {
                                    _ = self.generateVerificationCode(userMobileNumber!)
                                }
                            }
                            
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
    }
    
    func checkVerification() -> Bool {
        return UserDefaults.standard.bool(forKey: AppConstants.VERIFICATION_CODE_VERIFIED_KEY)    }
    
    func generateVerificationCode(_ mobileNumber : String) -> Bool {
        //var isGenerated : Bool! = false
        
        let verificationCode : String? = Helper.sharedInstance.verificationCode();
        if verificationCode != nil {
            UserDefaults.standard.set(verificationCode, forKey: AppConstants.VERIFICATION_CODE_KEY)
            UserDefaults.standard.set(false, forKey: AppConstants.VERIFICATION_CODE_VERIFIED_KEY)
            let sendVerificationURL : String = String(format : AppConstants.SMS_VERIFICATION_API, mobileNumber, verificationCode!)
            ServerClass.sharedInstance.sendVerificationCodeToUserMobile(sendVerificationURL, mobileNumber, { (success, message) in
                DispatchQueue.main.sync {
                    OperationQueue.main.addOperation {
                        Helper.sharedInstance.fadeOutLoaderView()
                        if success {
                            self.performSegue(withIdentifier: AppConstants.VERIFICATION_PAGE_SEGUE, sender: nil)
                        } else {
                            let alertString = message
                            let popupLabel : UILabel? = Helper.sharedInstance.popupLabelForCustomAlert(("\(alertString)"), baseView: self.view)
                            Helper.sharedInstance.fadeInAlertPopup(popupLabel)
                        }
                    }
                }
            })
            return true
        }
        return false
    }
    
    func validateLoginFields() -> Bool {
        var showPopup : Bool = false
        var alertString : String = ""
        
        let emailOrMobileString : String = emailOrMobileField.text!
        let passwordString : String = passwordField.text!
        
        if emailOrMobileString.characters.count == 0 {
            showPopup = true
            alertString = "Please enter your email id"
        } else if passwordString.characters.count == 0 {
            showPopup = true
            alertString = "Please enter the password"
        }
        
        if showPopup == false {
            let isEmailOrMobileFieldValidated : Bool = Helper.sharedInstance.validateEmailOrMobile(emailOrMobileString: emailOrMobileString)
            if !isEmailOrMobileFieldValidated {
                showPopup = true
                alertString = "Please enter valid email or mobile"
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
    
    @IBAction func loginWithFacebook(_ sender: Any) {
        let loginManager = FBSDKLoginManager()
        let permissions = ["public_profile", "email"];

        Helper.sharedInstance.fadeInLoaderView(self.view)
        loginManager.logIn(withReadPermissions: permissions, from: self, handler: { (loginResult, error) -> Void in
            if error == nil {
                let loginManagerResult : FBSDKLoginManagerLoginResult! = loginResult
                if loginManagerResult.isCancelled {
                    print("Cancelled")
                } else if ((loginManagerResult?.grantedPermissions.contains("email"))! && (loginManagerResult?.grantedPermissions.contains("public_profile"))!) {
                    self.registerWithFacebook()
                }
            }
        })
    }
    
    func registerWithFacebook() {
        if((FBSDKAccessToken.current()) != nil) {
            FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    let resultDict : NSDictionary = result as! NSDictionary
                    let userDetailsDataObject : UserDetailsDataObject = self.userDetailsFromFacebookGraphResult(resultDict: resultDict)
                    
                    let registerWithFacebookURLString : String! = String(format : AppConstants.REGISTER_WITH_FACEBOOK_API, userDetailsDataObject.name!, userDetailsDataObject.email!, userDetailsDataObject.password!, userDetailsDataObject.mobile!, userDetailsDataObject.streetAddress!, userDetailsDataObject.profileImageUrl!, userDetailsDataObject.city!, userDetailsDataObject.country!, userDetailsDataObject.organization!)
                    
                    self.registerUserWithFacebookDetails(urlString: registerWithFacebookURLString)
                }
            })
        }
    }
    
    func userDetailsFromFacebookGraphResult(resultDict : NSDictionary) -> UserDetailsDataObject {
        let userDetailsDataObject : UserDetailsDataObject = UserDetailsDataObject()
        userDetailsDataObject.name = resultDict.value(forKey: "name") as! String!
        userDetailsDataObject.email = resultDict.value(forKey: "email") as! String!
        userDetailsDataObject.password = resultDict.value(forKey: "id") as! String!
        
        let milliseconds : Int64 = 0
        let timeStamp = TimeInterval(milliseconds)/1000.0
        userDetailsDataObject.mobile = String(timeStamp)
        
        userDetailsDataObject.streetAddress = ""
        userDetailsDataObject.profileImageUrl = ((resultDict.value(forKey: "picture") as! NSDictionary!).value(forKey: "data") as! NSDictionary).value(forKey: "url") as! String
        userDetailsDataObject.city = ""
        userDetailsDataObject.country = ""
        userDetailsDataObject.organization = ""
        userDetailsDataObject.userId = ""
        
        return userDetailsDataObject
    }
    
    func registerUserWithFacebookDetails(urlString : String) {
        ServerClass.sharedInstance.performRegisterActionWithFacebook(urlString as String, { (success, message, dataArray) in
            DispatchQueue.main.sync(execute: {
                OperationQueue.main.addOperation {
                    Helper.sharedInstance.fadeOutLoaderView()
                    if success {
                        let userDataObject : UserDetailsDataObject = (dataArray?.lastObject as? UserDetailsDataObject)!
                        Helper.sharedInstance.currentUser = userDataObject
                        
                        self.performSegue(withIdentifier: AppConstants.CHOOSE_ONE_PAGE_SEGUE, sender: nil)
                    } else {
                        self.showAlertWithMessage(message: message)
                    }
                }
            })
        })
    }
    
    func showAlertWithMessage(message : String) {
        let popupLabel : UILabel? = Helper.sharedInstance.popupLabelForCustomAlert(("\(message)"), baseView: self.view)
        Helper.sharedInstance.fadeInAlertPopup(popupLabel)
    }
    
    @IBAction func stayLoggedInAction(_ sender: Any) {
        
        var image : UIImage = UIImage.init(named: "Circle With Tick")!
        
        if shouldStayLoggedIn == true {
            image = UIImage.init(named: "Circle without Tick")!
            shouldStayLoggedIn = false
        } else {
            shouldStayLoggedIn = true
        }
        stayLogginginButton.setImage(image, for: UIControlState.normal)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.backButtonAction(nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
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
