//
//  AppConstants.swift
//  HopOn
//
//  Created by ROHIT SARAF on 11/11/16.
//  Copyright © 2016 AppLives. All rights reserved.
//

import UIKit

class AppConstants: NSObject {
    
    static let SERVER_API : String = "http://appscoopsolutions.com/aim_api/hopon.php?%@"
    static let REGISTER_API : String = String(format : AppConstants.SERVER_API, "rule=register&full_name=%@&email=%@&password=%@&mobile=%@&street_address=%@&city=%@&country=%@&organisation=%@&user_id=%@&device_type=%@&device_id=%@")
    static let SMS_VERIFICATION_API : String = "http://smsgateway.ca/SendSMS.aspx?AccountKey=V34TIzaa7H5D0HV12N1sI06Aiy21C0lY&CellNumber=%@&MessageBody=%@&Reference=ref"
    static let LOGIN_API : String = "http://appscoopsolutions.com/aim_api/hopon.php?rule=login&mobile=%@&password=%@"
    static let FORGOT_PASSWORD_API = "http://appscoopsolutions.com/aim_api/hopon.php?rule=forgot_password&email=%@"
    
    static var VERIFICATION_CODE_KEY = "VerificationCode"
    static var VERIFICATION_CODE_VERIFIED_KEY = "isVerified"
    
    static let VERIFICATION_PAGE_SEGUE = "VerificationPage"
    static let CHOOSE_ONE_PAGE_SEGUE = "ChooseOne"
    
    //API response keys
    static let FULL_NAME_API_KEY = "full_name"
    static let EMAIL_API_KEY = "email"
    static let PASSWORD_API_KEY = "password"
    static let MOBILE_API_KEY = "mobile"
    static let CITY_API_KEY = "city"
    static let COUNTRY_API_KEY = "country"
    static let ORGANISATION_API_VKEY = "organisation"
    
    static let MENU_ITEM_CELL_IDENTIFIER : String = "Menu Item Cell"
    
    static let GRADIENT_COLOR : UIColor = UIColor.init(red: 117 / 255.0, green: 135 / 255.0, blue: 75 / 255.0, alpha: 1)
    
    static let REAR_VIEW_WIDTH : CGFloat = 76
    static let MENU_BAR_ROWS_COUNT : Int = 8
    static let MENU_ITEM_ICON_SIZE : CGSize = CGSize.init(width: 46, height: 46)
    
    static var deviceType : DeviceType = DeviceType.none
    
    public enum DeviceType {
        case none
        case iPhone4Type
        case iPhone5Type
        case iPhone7Type
        case iPhone7PlusType
    }
    
    public enum Font : String {
        case CaviarDreamsRegular = "CaviarDreams"
        case CaviarDreamsBoldItalic = "CaviarDreams_BoldItalic"
        case CaviarDreamsItalic = "CaviarDreams_Italic"
        case CaviarDreamsBold = "CaviarDreams_Bold"
    }
    
    public enum MenuItemIndices : Int {
        case Profile = 0
        case Home = 1
        case ReferFriend = 2
        case Chat = 3
        case History = 4
        case Notification = 5
        case Help = 6
        case Settings = 7
    }
    
    public enum MenuItemImageNames : String {
        case Profile = "Profile Menu Icon"
        case Home = "Home Menu Icon"
        case ReferFriend = "ReferFriend Menu Icon"
        case Chat = "Chat Menu Icon"
        case History = "History Menu Icon"
        case Notification = "Notification Menu Icon"
        case Help = "Help Menu Icon"
        case Settings = "Settings Menu Icon"
    }

}
