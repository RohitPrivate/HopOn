//
//  RiderProfileViewController.swift
//  HopOn
//
//  Created by ROHIT SARAF on 21/11/16.
//  Copyright © 2016 AppLives. All rights reserved.
//

import UIKit

class RiderProfileViewController: ChooseOneViewController {
    
    var scrollViewContentSize : CGSize! = CGSize.zero
    var scrollViewContentOffset : CGPoint = CGPoint.zero
    var isRiderDataFetched : Bool = false
    var riderDetailsDataObject : RiderDetailsDataObject!

    @IBOutlet weak var riderDetailsFillUpBox: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pickUpDateField: UITextField!
    @IBOutlet weak var pickUpTimeField: UITextField!
    @IBOutlet weak var pickUpLocationField: UITextField!
    @IBOutlet weak var destinationField: UITextField!
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        if !isRiderDataFetched {
            self.fetchRiderData()
        }
        self.addDatePickerInputViewToDateFields(textField: pickUpDateField, target: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isRiderDataFetched {
            Helper.sharedInstance.fadeOutLoaderView()
        }
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isRiderDataFetched {
            Helper.sharedInstance.fadeOutLoaderView()
        } else {
            Helper.sharedInstance.fadeInLoaderView(self.view)
        }
        
        scrollViewContentSize.width = scrollView.contentSize.width
        scrollViewContentSize.height = ((riderDetailsFillUpBox?.frame.origin.y)! + (riderDetailsFillUpBox?.frame.size.height)! + 10)
        scrollView.contentSize = scrollViewContentSize
        scrollViewContentOffset = scrollView.contentOffset
        
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keybpoardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keybpoardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func fetchRiderData() {
        let riderDataUrlString : String = String(format : AppConstants.GET_RIDER_DETAILS_API, (Helper.sharedInstance.currentUser?.id)!)
        ServerClass.sharedInstance.fetchRiderData(riderDataUrlString as String, { (success, message, dataArray) in
            DispatchQueue.main.async(execute: {
                OperationQueue.main.addOperation {
                    self.isRiderDataFetched = true
                    Helper.sharedInstance.fadeOutLoaderView()
                    if success {
                        if (dataArray?.lastObject != nil) {
                            self.riderDetailsDataObject = dataArray?.lastObject as? RiderDetailsDataObject
                            self.populateRiderDetails(dataObject: self.riderDetailsDataObject)
                        }
                        if (self.pickUpDateField.text?.characters.count)! > 0 {
                            self.datePicker.date = Helper.sharedInstance.formattedDateFromString(stringDate: self.pickUpDateField.text!)
                        }
                    } else {
                        let popupLabel : UILabel? = Helper.sharedInstance.popupLabelForCustomAlert(("\(message)"), baseView: self.view)
                        Helper.sharedInstance.fadeInAlertPopup(popupLabel)
                    }
                }
            })
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    func populateRiderDetails(dataObject : RiderDetailsDataObject) {
        pickUpDateField.text! = dataObject.pickUpDate
        pickUpTimeField.text! = dataObject.pickUpTime
        pickUpLocationField.text! = dataObject.pickUpLocation
        destinationField.text! = dataObject.destination
    }
    
    func updateDateTextField(sender : Any) {
        let strDate = Helper.sharedInstance.formattedStringFromDate(date: datePicker.date)
        self.pickUpDateField.text = "\(strDate)"
    }

    @IBAction func openMenuAction(_ sender: Any) {
        if revealViewController() != nil {
            revealViewController().revealToggle(animated: true)
        }
    }
    
    @IBAction func goAction(_ sender: Any) {
        
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.backButtonAction()
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
