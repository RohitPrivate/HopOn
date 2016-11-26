//
//  ChooseOneViewController.swift
//  HopOn
//
//  Created by ROHIT SARAF on 10/11/16.
//  Copyright © 2016 AppLives. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ChooseOneViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var driverButton: UIButton!
    @IBOutlet weak var riderButton: UIButton!
    
    var isDriverButtonSelected : Bool! = false
    var isRiderButtonSelected : Bool! = false
    var locationManager : CLLocationManager?
    var userLocation : CLLocationCoordinate2D?
    var datePicker : UIDatePicker!
    var shouldStayLoggedIn : Bool! = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if revealViewController() != nil {
        self.view.addGestureRecognizer(revealViewController().panGestureRecognizer())
            revealViewController().setFrontViewPosition(FrontViewPosition.leftSide, animated: true)
            revealViewController().rearViewRevealWidth = AppConstants.REAR_VIEW_WIDTH
        }
        
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager?.delegate = self
            locationManager?.desiredAccuracy = kCLLocationAccuracyBest
            locationManager?.requestAlwaysAuthorization()
            locationManager?.startUpdatingLocation()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    @IBAction func driverButtonSelected(_ sender: Any) {
        if !isDriverButtonSelected! {
            isDriverButtonSelected = true
            isRiderButtonSelected = false
        } else {
            isDriverButtonSelected = false
        }
        
        if isDriverButtonSelected! {
            driverButton.setBackgroundImage(UIImage.init(named: "Driver Image Selected"), for: UIControlState.normal)
            riderButton.setBackgroundImage(UIImage.init(named: "Rider Icon"), for: UIControlState.normal)
        } else {
            driverButton.setBackgroundImage(UIImage.init(named: "Driver Icon"), for: UIControlState.normal)
        }
        
    }
    
    @IBAction func openMenuBar(_ sender: Any) {
        if revealViewController() != nil {
            revealViewController().revealToggle(animated: true)
        }
    }
    
    @IBAction func riderButtonSelected(_ sender: Any) {
        if !isRiderButtonSelected! {
            isRiderButtonSelected = true
            isDriverButtonSelected = false
        } else {
            isRiderButtonSelected = false
        }
        if isRiderButtonSelected! {
            riderButton.setBackgroundImage(UIImage.init(named: "Rider Image Selected"), for: UIControlState.normal)
            driverButton.setBackgroundImage(UIImage.init(named: "Driver Icon"), for: UIControlState.normal)
        } else {
            riderButton.setBackgroundImage(UIImage.init(named: "Rider Icon"), for: UIControlState.normal)
        }
    }
    
    @IBAction func startAction(_ sender: Any) {
        if isRiderButtonSelected == true {
            _ = [self.performSegue(withIdentifier: AppConstants.RIDER_PAGE_SEGUE, sender: nil)];
        } else if (isDriverButtonSelected == true) {
             _ = [self.performSegue(withIdentifier: AppConstants.DRIVER_PAGE_SEGUE, sender: nil)];
        } else {
            let alertPopUp : UILabel! = Helper.sharedInstance.popupLabelForCustomAlert("Please select Driver or Rider", baseView: self.view)!
            Helper.sharedInstance.fadeInAlertPopup(alertPopUp)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = locationManager!.location!.coordinate
        print("locations = \(locValue.latitude) \(locValue.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func addDatePickerInputViewToDateFields(textField : UITextField, target: Any) {
        let doneButtonHeight : CGFloat = 50
        let doneButtonWidth : CGFloat = 100
        let inputView = UIView(frame: CGRect(x:0, y:0, width:self.view.frame.width, height:240))
        
        datePicker = Helper.sharedInstance.datePickerWithTarget(target: self, action : #selector(RiderProfileViewController.updateDateTextField(sender:)))
        datePicker.frame = CGRect(x:0, y:doneButtonHeight, width:inputView.frame.size.width, height: (inputView.frame.size.height - doneButtonHeight))
        inputView.addSubview(datePicker)
        
        let doneButton = UIButton(frame: CGRect(x:(self.view.frame.size.width/2) - (doneButtonWidth/2), y:0, width:doneButtonWidth, height:doneButtonHeight))
        doneButton.setTitle("Done", for: UIControlState.normal)
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        doneButton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        doneButton.addTarget(self, action: #selector((target as AnyObject).resignDatePicker(sender:)), for: UIControlEvents.touchUpInside)
        
        inputView.addSubview(doneButton)
        
        textField.inputView = inputView
    }
    
    func resignDatePicker(sender : UIButton) {
        self.view.endEditing(true)
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
