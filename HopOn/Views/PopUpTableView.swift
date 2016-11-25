//
//  PopUpTableView.swift
//  HopOn
//
//  Created by ROHIT SARAF on 24/11/16.
//  Copyright © 2016 AppLives. All rights reserved.
//

import UIKit

extension UIView {
    class func loadFromNibNamed(_ nibNamed: String, bundle: Bundle? = nil) -> UIView {
        return (UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView)!
    }
}

class PopUpTableView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var numberOfSections : Int = 1
    var rowHeight : CGFloat = 50
    var listDataSource : NSArray!
    
    
    func initiateTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listDataSource == nil {
            return 0
        } else {
            return listDataSource.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cellIdentifier : String! = "Cell"
        var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
        }
        let data : NSArray = listDataSource?.object(at: indexPath.row) as! NSArray
        
        var countryCodeLabel : String = ""
        
        if (data.object(at: 0) as? String) != nil {
            countryCodeLabel = countryCodeLabel.appending((data.object(at: 0) as? String)!)
            countryCodeLabel = countryCodeLabel.appending(" | ")
        }
        if (data.object(at: 1) as? String) != nil {
            countryCodeLabel = countryCodeLabel.appending((data.object(at: 1) as? String)!)
        }
        cell?.textLabel?.font = UIFont.init(name: AppConstants.Font.CaviarDreamsRegular.rawValue, size: 13)
        cell?.textLabel?.text = countryCodeLabel
        
        return cell!
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.fadeOutPopUpView()
    }
    
    func fadeInPopUpView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 1
        })
    }
    
    func fadeOutPopUpView() {
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
        })
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
