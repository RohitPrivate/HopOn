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
