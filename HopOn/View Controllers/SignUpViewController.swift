//
//  SignUpViewController.swift
//  HopOn
//
//  Created by ROHIT SARAF on 04/11/16.
//  Copyright © 2016 AppLives. All rights reserved.
//

import UIKit

class SignUpViewController: WelcomeViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate {

    var scrollViewContentSize : CGSize! = CGSize.zero
    var scrollViewContentOffset : CGPoint! = CGPoint.zero
    var selectedTextField : UITextField?
    var isTermsAndConditionAccepted : Bool = false
    var uploadImageActionSheet : UIActionSheet!
    
    @IBOutlet weak var termsAndConditionsButton: UIButton!
    @IBOutlet weak var termsAndConditionsLabelButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var scrollContainerView: UIView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var reEnterPasswordField: UITextField!
    @IBOutlet weak var mobileNumberField: UITextField!
    @IBOutlet weak var organizationField: UITextField!
    
    @IBOutlet weak var signUpFillUpBox: UIImageView!
    @IBOutlet weak var countryCodeButton: UIButton!
    @IBOutlet weak var uploadImageButton: UIButton!
    
    @IBOutlet weak var topViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var termsAndConditionsViewBottomLayoutConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        selectedCountryCode = "+1"
    }
    
    func cancelNumberPad() {
        mobileNumberField.resignFirstResponder()
    }
    
    func doneWithNumberPad() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if AppConstants.deviceType == AppConstants.DeviceType.iPhone5Type {
            let font : UIFont = UIFont.init(name: "CaviarDreams", size: 16)!
            
            nameField.font = font
            emailField.font = font
            passwordField.font = font
            reEnterPasswordField.font = font
            mobileNumberField.font = font
            organizationField.font = font
        }

        let attributedText : NSMutableAttributedString = termsAndConditionsLabelButton.titleLabel!.attributedText as! NSMutableAttributedString
        
        attributedText.beginEditing()
        attributedText.addAttribute(NSFontAttributeName, value: UIFont(name: "CaviarDreams", size: 14) as Any, range: NSMakeRange(0, attributedText.length))
        attributedText.endEditing()
        
        termsAndConditionsLabelButton.setAttributedTitle(attributedText, for: UIControlState.normal)
    }
    
    override func viewDidLayoutSubviews() {
        if AppConstants.deviceType == AppConstants.DeviceType.iPhone5Type {
            topViewTopConstraint.constant = -5
            var scrollViewFrame : CGRect = scrollView.frame
            scrollViewFrame.size.height -= 20
            scrollView.frame = scrollViewFrame
            termsAndConditionsViewBottomLayoutConstraint.constant = 5
        } else if (AppConstants.deviceType == AppConstants.DeviceType.iPhone7Type) {
            
        } else if (AppConstants.deviceType == AppConstants.DeviceType.iPhone7PlusType) {
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scrollViewContentSize.width = scrollView.contentSize.width
        scrollViewContentSize.height = ((signUpFillUpBox?.frame.origin.y)! + (signUpFillUpBox?.frame.size.height)! + 10)
        scrollView.contentSize = scrollViewContentSize
        scrollViewContentOffset = scrollView.contentOffset
        
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keybpoardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keybpoardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        nameField.delegate = self
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    @IBAction func selectCountryCode(_ sender: Any) {
        countryButton = countryCodeButton
        self.createCountryCodeSelectionView()
    }
    
    //This method is used for the sign up process
    @IBAction func signUpAction(_ sender: Any) {
        //To dismiss the keyboard
        scrollView.endEditing(true)
        
        let isValidated : Bool = self.validateRegistrationFields()
        if isValidated {
            //Make server call to register the user and proceed            
            let registerURLString : String = String(format : AppConstants.REGISTER_API, nameField.text!, emailField.text!, passwordField.text!, mobileNumberField.text!,"", "", "", organizationField.text!, "userId", "iPhone", "deviceId")
            
            Helper.sharedInstance.fadeInLoaderView(self.view)
            
            ServerClass.sharedInstance.performRegisterAction(registerURLString as String, { (success, message, dataArray) in
                DispatchQueue.main.sync(execute: {
                    OperationQueue.main.addOperation {
                        if success {
                            let userDataObject : UserDetailsDataObject = (dataArray?.lastObject as? UserDetailsDataObject)!
                            Helper.sharedInstance.currentUser = userDataObject
                            _ = self.generateVerificationCode(self.mobileNumberField.text!)
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
    
    func generateVerificationCode(_ mobileNumber : String) -> Bool {
        //var isGenerated : Bool! = false
        
        let verificationCode : String? = Helper.sharedInstance.verificationCode();
        print("\(verificationCode)")
        if verificationCode != nil {
            UserDefaults.standard.set(verificationCode, forKey: AppConstants.VERIFICATION_CODE_KEY)
            let sendVerificationURL : String = String(format : AppConstants.SMS_VERIFICATION_API, mobileNumber, verificationCode!)
            print(sendVerificationURL)
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
    
    @IBAction func uploadProfileImage(_ sender: Any) {
        self.showUploadActionSheet()
    }
    
    func showUploadActionSheet() {
        if uploadImageActionSheet == nil {
            uploadImageActionSheet = UIActionSheet(title: "Choose Option", delegate: self, cancelButtonTitle: "Cancel", destructiveButtonTitle: nil, otherButtonTitles: "Upload with Camera", "Choose from Photos")
        }
        uploadImageActionSheet.show(in: self.view)
    }
    
    func actionSheet(_ actionSheet: UIActionSheet, clickedButtonAt buttonIndex: Int)
    {
        print("\(buttonIndex)")
        let imagePickerViewController = UIImagePickerController()
        imagePickerViewController.delegate = self
        imagePickerViewController.allowsEditing = false
        
        switch (buttonIndex) {
        case 0:
            print("Cancel")
        case 1:
            print("Upload with Camera")
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                imagePickerViewController.sourceType = .camera
                self.present(imagePickerViewController, animated: true, completion: { _ in
                })
            }
            else {
                print("Camera not available on the device")
            }
        case 2:
            print("Choose from Photos")
            imagePickerViewController.sourceType = .photoLibrary
            self.present(imagePickerViewController, animated: true, completion: { _ in
            })
        default:
            print("Default")
            //Some code here..
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: { (_ success) in
            let capturedImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            self.uploadImageButton.setImage(capturedImage, for: UIControlState.normal)
            print("i've got an image %@", capturedImage);
        })
    }
    
    @IBAction func selectOrDeselectTermsAndConditions(_ sender: Any) {
        var image : UIImage = UIImage.init(named: "Circle With Tick")!
        
        if isTermsAndConditionAccepted {
            image = UIImage.init(named: "Circle without Tick")!
            isTermsAndConditionAccepted = false
        } else {
            isTermsAndConditionAccepted = true
        }
        termsAndConditionsButton.setImage(image, for: UIControlState.normal)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.backButtonAction(nil)
    }
    
    func validateRegistrationFields() -> Bool {
        var showPopup : Bool = false
        var alertString : String = ""
        
        let nameString : String = nameField.text!
        let emailString : String = emailField.text!
        let passwordString : String = passwordField.text!
        let reEnterPasswordString : String = reEnterPasswordField.text!
        let mobileNumberString : String = mobileNumberField.text!
        let organizationString : String = organizationField.text!
        
        if nameString.characters.count == 0 {
            showPopup = true
            alertString = "Please enter your name"
        } else if emailString.characters.count == 0 {
            showPopup = true
            alertString = "Please enter your email id"
        } else if passwordString.characters.count == 0 {
            showPopup = true
            alertString = "Please enter your password"
        } else if reEnterPasswordString.characters.count == 0 {
            showPopup = true
            alertString = "Please re-enter your password"
        } else if mobileNumberString.characters.count == 0 {
            showPopup = true
            alertString = "Please enter your mobile number"
        } else if organizationString.characters.count == 0 {
            showPopup = true
            alertString = "Please enter your Organization Name"
        }
        
        if showPopup == false {
            let isEmailValidated : Bool = Helper.sharedInstance.validateEmail(emailString)
            if isEmailValidated == false {
                showPopup = true
                alertString = "Please enter valid email id"
            } else if passwordString != reEnterPasswordString {
                showPopup = true
                alertString = "The password you entered do not match"
            } else if (mobileNumberString.characters.count < 10 || mobileNumberString.characters.count > 10 || !Helper.sharedInstance.isMobileNumber(emailOrMobileString: mobileNumberString)) {
                showPopup = true
                alertString = "Please enter a valid mobile number"
            } else if !isTermsAndConditionAccepted {
                showPopup = true
                alertString = "Please accept the terms & conditions"
            } else if (passwordString.contains(" ")) {
                showPopup = true
                alertString = "Please remove space from password"
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
    
    func keybpoardWillShow(notification : NSNotification) {
        scrollView.isScrollEnabled = true
        
        var  contentSize : CGSize! = scrollView.contentSize;
                
        //if scrollView.contentOffset.y <= -20 {
            let keyboardFrame : CGRect = (((notification.userInfo! as NSDictionary).object(forKey: UIKeyboardFrameBeginUserInfoKey) as AnyObject).cgRectValue)!
            contentSize.height = scrollViewContentSize.height + (keyboardFrame.size.height - (self.view.frame.size.height - (scrollView.frame.origin.y + scrollView.frame.size.height)))
            //var yOffset = (scrollView.frame.origin.y + (selectedTextField?.superview?.superview?.frame.origin.y)! + (selectedTextField?.superview?.frame.origin.y)! + (selectedTextField?.frame.origin.y)!) + scrollView.contentOffset.y
            //if yOffset > keyboardFrame.origin.y {
                //yOffset = keyboardFrame.size.height
            //}
            
            UIView.animate(withDuration: 0.2, animations: {
                self.scrollView.contentSize = contentSize
                //self.scrollView.contentOffset.y = yOffset
            })
        //}
    }
    
    func keybpoardWillHide(notification : NSNotification) {        
        UIView.animate(withDuration: 0.2, animations: {
            self.scrollView.contentSize = self.scrollViewContentSize
            self.scrollView.contentOffset = self.scrollViewContentOffset
        })
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        selectedTextField = textField
        return true
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
