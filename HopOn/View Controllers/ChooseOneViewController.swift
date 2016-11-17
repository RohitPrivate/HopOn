//
//  ChooseOneViewController.swift
//  HopOn
//
//  Created by ROHIT SARAF on 10/11/16.
//  Copyright © 2016 AppLives. All rights reserved.
//

import UIKit

class ChooseOneViewController: WelcomeViewController {

    @IBOutlet weak var driverButton: UIButton!
    @IBOutlet weak var riderButton: UIButton!
    
    var isDriverButtonSelected : Bool! = false
    var isRiderButtonSelected : Bool! = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
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
