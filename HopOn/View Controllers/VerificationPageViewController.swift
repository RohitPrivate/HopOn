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
                    UserDefaults.standard.set(true, forKey: AppConstants.VERIFICATION_CODE_VERIFIED_KEY)
                    self.performSegue(withIdentifier: AppConstants.CHOOSE_ONE_PAGE_SEGUE, sender: nil)
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
