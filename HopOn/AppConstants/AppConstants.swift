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
    
    static var VERIFICATION_CODE_KEY = "VerificationCode"
    
    static let VERIFICATION_PAGE_SEGUE = "VerificationPage"
    static let CHOOSE_ONE_PAGE_SEGUE = "ChooseOne"
    
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

}
