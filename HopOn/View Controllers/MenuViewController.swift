//
//  MenuViewController.swift
//  HopOn
//
//  Created by ROHIT SARAF on 18/11/16.
//  Copyright © 2016 AppLives. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.backgroundColor = AppConstants.GRADIENT_COLOR
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppConstants.MENU_BAR_ROWS_COUNT
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier : String = AppConstants.MENU_ITEM_CELL_IDENTIFIER
        var cell : MenuItemTableViewCell! = (tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? MenuItemTableViewCell)!
        if cell == nil {
            cell = MenuItemTableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: cellIdentifier)
            cell?.contentView.backgroundColor = UIColor.clear
        }
        
        let imageName : String? = self.getMenuItemImageName(indexPath: indexPath as NSIndexPath)
        cell.setItemImage(imageName: imageName)
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ((self.view.frame.size.height - 20) / CGFloat(AppConstants.MENU_BAR_ROWS_COUNT))
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    func getMenuItemImageName(indexPath : NSIndexPath) -> String {
        var imageName : String! = ""
        switch indexPath.row {
        case AppConstants.MenuItemIndices.Profile.rawValue:
            imageName = AppConstants.MenuItemImageNames.Profile.rawValue
            break
        case AppConstants.MenuItemIndices.Home.rawValue:
            imageName = AppConstants.MenuItemImageNames.Home.rawValue
            break
        case AppConstants.MenuItemIndices.ReferFriend.rawValue:
            imageName = AppConstants.MenuItemImageNames.ReferFriend.rawValue
            break
        case AppConstants.MenuItemIndices.Chat.rawValue:
            imageName = AppConstants.MenuItemImageNames.Chat.rawValue
            break
        case AppConstants.MenuItemIndices.History.rawValue:
            imageName = AppConstants.MenuItemImageNames.History.rawValue
            break
        case AppConstants.MenuItemIndices.Notification.rawValue:
            imageName = AppConstants.MenuItemImageNames.Notification.rawValue
            break
        case AppConstants.MenuItemIndices.Help.rawValue:
            imageName = AppConstants.MenuItemImageNames.Help.rawValue
            break
        case AppConstants.MenuItemIndices.Settings.rawValue:
            imageName = AppConstants.MenuItemImageNames.Settings.rawValue
            break
        default:
            imageName = ""
        }
        
        return imageName
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
