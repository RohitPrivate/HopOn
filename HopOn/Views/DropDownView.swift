//
//  DropDownView.swift
//  HopOn
//
//  Created by ROHIT SARAF on 01/12/16.
//  Copyright © 2016 AppLives. All rights reserved.
//

import UIKit

extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}

class DropDownView: UIView {
    
    var isDropdownSelected : Bool = false
    let rowHeight = 44

    @IBOutlet weak var tableView: UITableView!
    
    var target : AnyObject!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setTargetForDropdown(_ target_: AnyObject) {
        target = target_
        
        tableView.delegate = target as! PickUpLocationViewController
        tableView.dataSource = target as! PickUpLocationViewController
        
        var tableViewFrame : CGRect = tableView.frame
        
        tableViewFrame.origin.y = 0
        tableViewFrame.size.height = self.bounds.size.height
        tableViewFrame.size.width = self.bounds.size.width
        
        tableView.frame = tableViewFrame
    }
    
    func reloadDropDown() {
        self.tableView.reloadData()
    }
    
    func handleDropdownVisibillity() {
        if isDropdownSelected {
            self.fadeOutDropdownView()
        } else {
            self.fadeInDropdownVew()
        }
    }
    
    func fadeInDropdownVew() {
        isDropdownSelected = true
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 1
        })
    }
    
    func fadeOutDropdownView() {
        isDropdownSelected = false
        UIView.animate(withDuration: 0.2, animations: {
            self.alpha = 0
            self.removeFromSuperview()
        })
    }
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */

}
