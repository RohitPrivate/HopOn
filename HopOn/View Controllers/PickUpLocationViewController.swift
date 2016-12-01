//
//  PickUpLocationViewController.swift
//  HopOn
//
//  Created by ROHIT SARAF on 30/11/16.
//  Copyright © 2016 AppLives. All rights reserved.
//

import UIKit
import GooglePlaces

class PickUpLocationViewController: ChooseOneViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var startLocation : GMSAutocompletePrediction?
    var destinationLocation : GMSAutocompletePrediction?
    
    var dropDownData : NSArray?
    var selectedLocation : String?
    
    var dropdownView : DropDownView? = nil
    var selectedLocationTextField: UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(PickUpLocationViewController.textFieldDidChange(_:)), name: NSNotification.Name.UITextFieldTextDidChange, object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
    }

    @IBAction func cancelAction(_ sender: Any) {
        self.backButtonAction()
    }
    
    @IBAction override func openMenuBar(_ sender: Any) {
        self.showMenuBar()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        selectedTextField = textField
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.dropdownView?.isDropdownSelected = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.clearSelectedLocation(textField)
        self.dropdownView?.isDropdownSelected = true
        self.dropdownView?.handleDropdownVisibillity()
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidChange(_ notification : Notification) {
        let textField = notification.object as! UITextField
        
        self.clearSelectedLocation(textField)
        let xPadding = 10
        
        let dropdownFrame : CGRect = CGRect.init(x: textField.frame.origin.x + (textField.superview?.frame.origin.x)! - CGFloat(xPadding), y: textField.frame.origin.y + textField.frame.size.height + (textField.superview?.frame.origin.y)! + CGFloat(AppConstants.HEADER_HEIGHT), width: textField.frame.size.width + CGFloat(xPadding), height: CGFloat(44 * 5))
        self.dropDownView(dropdownFrame)
        self.placeAutoComplete(textField.text)
    }
    
    func dropDownView(_ frame : CGRect) {
        if dropdownView == nil {
            dropdownView = (DropDownView.loadFromNibNamed(nibNamed: "DropDownView") as! DropDownView)
            dropdownView?.frame = CGRect.init(origin: frame.origin, size: frame.size)
            dropdownView?.alpha = 0
            dropdownView?.backgroundColor = UIColor.white
            dropdownView?.layer.cornerRadius =   15
        } else {
            dropdownView?.frame = frame
        }
        dropdownView?.setTargetForDropdown(self)
        self.reFrameDropdownView()
        self.view.addSubview(dropdownView!)
    }
    
    func reFrameDropdownView() {
        if dropdownView?.tableView != nil && dropDownData != nil {
            let tableViewFrame : CGRect = dropdownView!.tableView.frame
            dropdownView!.tableView.frame = tableViewFrame
        } else if dropdownView?.tableView != nil {
            var tableViewFrame : CGRect = dropdownView!.tableView.frame
            tableViewFrame.size.height = 0
            dropdownView!.tableView.frame = tableViewFrame
            dropdownView?.tableView.backgroundColor = UIColor.white
        }
    }
    
    func clearSelectedLocation(_ textField : UITextField) {
        if textField.text?.characters.count == 0 {
                startLocation = nil
                destinationLocation = nil
            }
    }
    
    func placeAutoComplete(_ string : String?) {
        let autoCompleteFilter = GMSAutocompleteFilter()
        
        autoCompleteFilter.type = .noFilter
        
        let placesClient = GMSPlacesClient.shared()
        placesClient.autocompleteQuery(string!, bounds: nil, filter: autoCompleteFilter, callback: {(results, error) -> Void in
            self.dropDownData = results as NSArray?
            DispatchQueue.main.async(execute: { 
                self.reFrameDropdownView()
                self.dropdownView!.reloadDropDown()
                self.dropdownView!.isDropdownSelected = false
                self.dropdownView?.handleDropdownVisibillity()
            })
            print(error?.localizedDescription)
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cellIdentifier : String! = "Cell"
        var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
        }
        let data = dropDownData?.object(at: indexPath.row)
        
        if data is String {
            cell?.textLabel?.text = data as? String
        } else if data is GMSAutocompletePrediction {
            cell?.textLabel?.attributedText = (data as! GMSAutocompletePrediction).attributedFullText
        }
        
        
        cell?.backgroundColor = UIColor.clear
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dropDownData != nil {
            return dropDownData!.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = dropDownData?.object(at: indexPath.row)
        
        if data is String {
            //selectedLocation = dropDownData?.object(at: indexPath.row) as? String
            selectedLocationTextField?.text = dropDownData?.object(at: indexPath.row) as? String
        } else if data is GMSAutocompletePrediction {
//            if toField.isFirstResponder {
//                toLocation = data as? GMSAutocompletePrediction
//                toField.attributedText = toLocation!.attributedFullText
//            } else if fromField.isFirstResponder {
//                fromLocation = data as? GMSAutocompletePrediction
//                fromField.attributedText = fromLocation!.attributedFullText
//            }
        }
        
        dropdownView!.fadeOutDropdownView()
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
