//
//  DriverProfileViewController.swift
//  HopOn
//
//  Created by ROHIT SARAF on 21/11/16.
//  Copyright © 2016 AppLives. All rights reserved.
//

import UIKit

class DriverProfileViewController: ChooseOneViewController {
    
    var scrollViewContentSize : CGSize! = CGSize.zero
    var scrollViewContentOffset : CGPoint = CGPoint.zero
    var isDriverDataFetched : Bool = false
    var driverDetailsDataObject : DriverDetailsDataObject!

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var carDetailsFillUpBox: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var driveDateField: UITextField!
    @IBOutlet weak var driveTimeField: UITextField!
    @IBOutlet weak var startLocationField: UITextField!
    @IBOutlet weak var destinationField: UITextField!
    @IBOutlet weak var noOfSeatsField: UITextField!
    @IBOutlet weak var chargePerPersonField: UITextField!
    @IBOutlet weak var carNumberField: UITextField!
    @IBOutlet weak var carModelField: UITextField!
    @IBOutlet weak var carTypeField: UITextField!
    @IBOutlet weak var carColorField: UITextField!
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
        if !isDriverDataFetched {
            self.fetchDriverData()
        }
        
        self.addDatePickerInputViewToDateFields(textField: driveDateField, target: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isDriverDataFetched {
            Helper.sharedInstance.fadeOutLoaderView()
        }
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if isDriverDataFetched {
            Helper.sharedInstance.fadeOutLoaderView()
        } else {
            Helper.sharedInstance.fadeInLoaderView(self.view)
        }
            
        scrollViewContentSize.width = scrollView.contentSize.width
        scrollViewContentSize.height = ((carDetailsFillUpBox?.frame.origin.y)! + (carDetailsFillUpBox?.frame.size.height)! + 10)
        scrollView.contentSize = scrollViewContentSize
        scrollViewContentOffset = scrollView.contentOffset
        
        NotificationCenter.default.addObserver(self, selector: #selector(DriverProfileViewController.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(DriverProfileViewController.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    func updateDateTextField(sender : Any) {
        let strDate = Helper.sharedInstance.formattedStringFromDate(date: datePicker.date)
        self.driveDateField.text = "\(strDate)"
    }

    @IBAction func openMenuAction(_ sender: Any) {
        if revealViewController() != nil {
            revealViewController().revealToggle(animated: true)
        }
    }
    
    @IBAction func goAction(_ sender: Any) {
        
    }
    
    func fetchDriverData() {
        let driverDataUrlString : String = String(format : AppConstants.GET_DRIVER_DETAILS_API, (Helper.sharedInstance.currentUser?.id)!)
        ServerClass.sharedInstance.fetchDriverData(driverDataUrlString as String, { (success, message, dataArray) in
            DispatchQueue.main.sync(execute: {
                OperationQueue.main.addOperation {
                    self.isDriverDataFetched = true
                    Helper.sharedInstance.fadeOutLoaderView()
                    if success {
                        if (dataArray?.lastObject != nil) {
                            self.driverDetailsDataObject = dataArray?.lastObject as? DriverDetailsDataObject
                            self.populateDriverDetails(dataObject: self.driverDetailsDataObject)
                        }
                        if (self.driveDateField.text?.characters.count)! > 0 {
                            self.datePicker.date = Helper.sharedInstance.formattedDateFromString(stringDate: self.driveDateField.text!)
                        }
                    } else {
                        let popupLabel : UILabel? = Helper.sharedInstance.popupLabelForCustomAlert(("\(message)"), baseView: self.view)
                        Helper.sharedInstance.fadeInAlertPopup(popupLabel)
                    }
                }
            })
        })
    }
    
    func populateDriverDetails(dataObject : DriverDetailsDataObject) {
        driveDateField.text! = dataObject.driveDate
        driveTimeField.text! = dataObject.driveTime
        startLocationField.text! = dataObject.startLocation
        destinationField.text! = dataObject.destination
        noOfSeatsField.text! = dataObject.carDetails.noOfSeats
        chargePerPersonField.text! = dataObject.carDetails.chargePerPerson
        carNumberField.text! = dataObject.carDetails.carNumber
        carModelField.text! = dataObject.carDetails.carModel
        carTypeField.text! = dataObject.carDetails.carType
        carColorField.text! = dataObject.carDetails.carColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    func keyboardWillShow(notification : NSNotification) {
        scrollView.isScrollEnabled = true
        
        var  contentSize : CGSize! = scrollView.contentSize;
        
        let keyboardFrame : CGRect = (((notification.userInfo! as NSDictionary).object(forKey: UIKeyboardFrameBeginUserInfoKey) as AnyObject).cgRectValue)!
        contentSize.height = scrollViewContentSize.height + (keyboardFrame.size.height - (self.view.frame.size.height - (scrollView.frame.origin.y + scrollView.frame.size.height)))
        
        UIView.animate(withDuration: 0.2, animations: {
            self.scrollView.contentSize = contentSize
        })
    }
    
    func keyboardWillHide(notification : NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.scrollView.contentSize = self.scrollViewContentSize
            self.scrollView.contentOffset = self.scrollViewContentOffset
        })
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
