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
    static let VERIFY_USER_API = "http://appscoopsolutions.com/aim_api/hopon.php?rule=set_verify&user_id=%@"
    static let CHECK_VERIFICATION_STATUS_API = "http://appscoopsolutions.com/aim_api/hopon.php?rule=verify_user&user_id=%@"
    static let REGISTER_WITH_FACEBOOK_API = "http://appscoopsolutions.com/aim_api/hopon.php?rule=register_fb&device_type=2&device_id=ggyt54545&full_name=%@&email=%@&password=%@&mobile=%@&street_address=%@&profile_image=%@&city=%@&country=%@&organisation=%@"
    static let GET_DRIVER_DETAILS_API = "http://appscoopsolutions.com/aim_api/hopon.php?rule=get_drive_details&user_id=%@"
    static let GET_RIDER_DETAILS_API = "http://appscoopsolutions.com/aim_api/hopon.php?rule=get_ride_details&user_id=%@"
    static let SAVE_DRIVER_DETAILS_API = "http://appscoopsolutions.com/aim_api/hopon.php?rule=drive_details&user_id=87&lattitude=%@&longitude=%@&drive_date=%@&drive_time=%@&start_loc=%@&destination=%@&seat_available=%@&rate_per_person=%@&car_model=%@&car_type=%@&car_color=%@"
    static let SAVE_RIDER_DETAILS_API = "http://appscoopsolutions.com/aim_api/hopon.php?rule=rider_details&pickup_date=%@&pickup_time=%@&pickup_loc=%@&destination=%@&lattitude=%@&longitude=%@&profile_image=%@&user_id=87"
    
    static var VERIFICATION_CODE_KEY = "VerificationCode"
    static var SHOULD_STAY_LOGGED_IN = "ShouldStayLoggedIn"
    
    static let VERIFICATION_PAGE_SEGUE = "VerificationPage"
    static let CHOOSE_ONE_PAGE_SEGUE = "ChooseOne"
    static let RIDER_PAGE_SEGUE = "Rider Page"
    static let DRIVER_PAGE_SEGUE = "Driver Page"
    
    //API response keys
    //User Details
    static let FULL_NAME_API_KEY = "full_name"
    static let EMAIL_API_KEY = "email"
    static let PASSWORD_API_KEY = "password"
    static let MOBILE_API_KEY = "mobile"
    static let STREET_ADDRESS_API_KEY = "mobile"
    static let CITY_API_KEY = "city"
    static let COUNTRY_API_KEY = "country"
    static let ORGANIZATION_API_KEY = "organisation"
    static let USER_ID_API_KEY = "user_id"
    static let DEVICE_TYPE_API_KEY = "device_type"
    static let DEVICE_ID_API_KEY = "device_id"
    static let PROFILE_IMAGE_URL_API_KEY = "profile_image"
    static let ID_API_KEY = "id"
    
    //API response keys
    //Driver Details
    static let LATTITUDE_API_KEY = "lattitude"
    static let LONGITUDE_API_KEY = "longitude"
    static let DRIVE_DATE_API_KEY = "drive_date"
    static let DRIVE_TIME_API_KEY = "drive_time"
    static let START_LOCATION_API_KEY = "start_loc"
    static let DESTINATION_API_KEY = "destination"
    
    //API response keys
    //Car Details
    static let SEATS_AVAILABLE_API_KEY = "seat_available"
    static let RATE_API_KEY = "rate"
    static let CAR_MODEL_API_KEY = "car_model"
    static let CAR_TYPE_API_KEY = "car_type"
    static let CAR_COLOR_API_KEY = "car_color"
    static let CAR_NUMBER_API_KEY = "car_number"
    
    //API response keys
    //Rider Details
    static let PICK_UP_DATE_API_KEY = "pickup_dt"
    static let PICK_UP_TIME_API_KEY = "pickup_tm"
    static let PICK_UP_LOCATION_API_KEY = "pickup_loc"
    
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
