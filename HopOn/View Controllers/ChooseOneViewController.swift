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

class ChooseOneViewController: UIViewController, CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource  {

    @IBOutlet weak var driverButton: UIButton!
    @IBOutlet weak var riderButton: UIButton!
    
    var isDriverButtonSelected : Bool! = false
    var isRiderButtonSelected : Bool! = false
    var locationManager : CLLocationManager?
    var userLocation : CLLocationCoordinate2D?
    var timePickerDataSource : NSDictionary?
    
    var datePicker : UIDatePicker!
    var timePickerView : UIPickerView!
    var selectedTextField : UITextField!
    
    var shouldStayLoggedIn : Bool! = false
    var popUpTableView : PopUpTableView!
    
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
        
        UserDefaults.standard.set(true, forKey: AppConstants.VISITED_DASHBOARD)
        if UserDefaults.standard.bool(forKey: AppConstants.SHOULD_STAY_LOGGED_IN) && Helper.sharedInstance.currentUser != nil {
            let encodedData : Data = NSKeyedArchiver.archivedData(withRootObject: Helper.sharedInstance.currentUser!)
            UserDefaults.standard.set(encodedData, forKey: AppConstants.LOGGED_IN_USER_OBJECT)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        isRiderButtonSelected = false
        isDriverButtonSelected = false
        
        riderButton.setBackgroundImage(UIImage.init(named: "Rider Icon"), for: UIControlState.normal)
        driverButton.setBackgroundImage(UIImage.init(named: "Driver Icon"), for: UIControlState.normal)
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
        self.showMenuBar()
    }
    
    func showMenuBar() {
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
        Helper.sharedInstance.currentLocation = locationManager!.location!.coordinate
        print("locations = \(locationManager!.location!.coordinate.latitude) \(locationManager!.location!.coordinate.longitude)")
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func addDatePickerInputViewToFields(textField : UITextField, target: Any, action : Selector, type : AppConstants.InputType) {
        let doneButtonHeight : CGFloat = 50
        let doneButtonWidth : CGFloat = 100
        let inputView = UIView(frame: CGRect(x:0, y:0, width:self.view.frame.width, height:240))
        
        if type == AppConstants.InputType.date {
        datePicker = Helper.sharedInstance.datePickerWithTarget(target: self, action : action)
        datePicker.date = Date()
        datePicker?.frame = CGRect(x:0, y:doneButtonHeight, width:inputView.frame.size.width, height: (inputView.frame.size.height - doneButtonHeight))
        inputView.addSubview(datePicker!)
        
        let doneButton = UIButton(frame: CGRect(x:(self.view.frame.size.width/2) - (doneButtonWidth/2), y:0, width:doneButtonWidth, height:doneButtonHeight))
        doneButton.setTitle("Done", for: UIControlState.normal)
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        doneButton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        doneButton.addTarget(target, action: #selector((target as AnyObject).resignDatePicker(sender:)), for: UIControlEvents.touchUpInside)
        
        inputView.addSubview(doneButton)
        
        textField.inputView = inputView
        }
    }
    
    func addTimePickerInputViewToFields(textField : UITextField, target: Any, action : Selector, type : AppConstants.InputType) {
        
        selectedTextField = textField
        
        let doneButtonHeight : CGFloat = 50
        let doneButtonWidth : CGFloat = 100
        let inputView = UIView(frame: CGRect(x:0, y:0, width:self.view.frame.width, height:240))
        
        timePickerView = Helper.sharedInstance.timePicker()
        timePickerView?.frame = CGRect(x:0, y:doneButtonHeight, width:inputView.frame.size.width, height: (inputView.frame.size.height - doneButtonHeight))

        self.dataSourceForTimePicker()
        
        timePickerView.delegate = self
        timePickerView.dataSource = self
        
        inputView.addSubview(timePickerView!)
        
        let doneButton = UIButton(frame: CGRect(x:(self.view.frame.size.width/2) - (doneButtonWidth/2), y:0, width:doneButtonWidth, height:doneButtonHeight))
        doneButton.setTitle("Done", for: UIControlState.normal)
        doneButton.setTitle("Done", for: UIControlState.highlighted)
        doneButton.setTitleColor(UIColor.black, for: UIControlState.normal)
        doneButton.setTitleColor(UIColor.gray, for: UIControlState.highlighted)
        doneButton.addTarget(target, action: #selector((target as AnyObject).resignDatePicker(sender:)), for: UIControlEvents.touchUpInside)
        
        inputView.addSubview(doneButton)
        
        textField.inputView = inputView
    }
    
    func dataSourceForTimePicker() {
        let filePath = Bundle.main.path(forResource: "PickTimeList", ofType: "plist")
        if filePath != nil {
            timePickerDataSource = NSDictionary.init(contentsOfFile: filePath!)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return (timePickerDataSource?.object(forKey: "Time") as! NSArray).count
        } else if (component == 1) {
            return (timePickerDataSource?.object(forKey: "Format") as! NSArray).count
        }
        return 0
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return (timePickerDataSource?.allKeys.count)!
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var dataArray : NSArray? = NSArray.init()
        
        if component == 0 {
            dataArray = (timePickerDataSource?.object(forKey: "Time") as! NSArray)
        } else if (component == 1) {
            dataArray = (timePickerDataSource?.object(forKey: "Format") as! NSArray)
        }
        return (dataArray?.object(at: row) as! String)
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedTime = (timePickerDataSource?.object(forKey: "Time") as! NSArray).object(at: pickerView.selectedRow(inComponent: 0)) as! String
        let selectedFormat = (timePickerDataSource?.object(forKey: "Format") as! NSArray).object(at: pickerView.selectedRow(inComponent: 1)) as! String
        
        if selectedTextField != nil {
            selectedTextField.text = selectedTime + " " + selectedFormat
        }
    }
    
    func setTimePickerIndex(pickerView : UIPickerView, time : String) {
        
    }
    
    func resignDatePicker(sender : UIButton) {
        self.view.endEditing(true)
    }
    
    func resignTimePicker(sender : UIButton) {
        self.view.endEditing(true)
    }
    
    func backButtonAction() {
        _ = self.navigationController?.popViewController(animated: true)
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
