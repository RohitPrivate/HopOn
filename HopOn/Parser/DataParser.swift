//
//  DataParser.swift
//  HopOn
//
//  Created by ROHIT SARAF on 22/11/16.
//  Copyright © 2016 AppLives. All rights reserved.
//

import UIKit

class DataParser: NSObject {
    
    func parseUserDataDictionary(dataDict : NSDictionary) -> NSArray {
        let userArray : NSMutableArray? = NSMutableArray.init()
        
        let userDataObject : UserDetailsDataObject = UserDetailsDataObject()
        
        userDataObject.name = dataDict.value(forKey: AppConstants.FULL_NAME_API_KEY) as! String!
        userDataObject.email = dataDict.value(forKey: AppConstants.EMAIL_API_KEY) as! String!
        userDataObject.password = dataDict.value(forKey: AppConstants.PASSWORD_API_KEY) as! String!
        userDataObject.mobile = dataDict.value(forKey: AppConstants.MOBILE_API_KEY) as! String!
        userDataObject.streetAddress = dataDict.value(forKey: AppConstants.STREET_ADDRESS_API_KEY) as! String!
        userDataObject.profileImageUrl = dataDict.value(forKey: AppConstants.PROFILE_IMAGE_URL_API_KEY) as! String!
        userDataObject.city = dataDict.value(forKey: AppConstants.CITY_API_KEY) as! String!
        userDataObject.country = dataDict.value(forKey: AppConstants.COUNTRY_API_KEY) as! String!
        userDataObject.organization = dataDict.value(forKey: AppConstants.ORGANIZATION_API_KEY) as! String!
        userDataObject.userId = dataDict.value(forKey: AppConstants.USER_ID_API_KEY) as! String!
        userDataObject.deviceId = dataDict.value(forKey: AppConstants.DEVICE_ID_API_KEY) as! String!
        userDataObject.deviceType = dataDict.value(forKey: AppConstants.DEVICE_TYPE_API_KEY) as! String!
        userDataObject.id = dataDict.value(forKey: AppConstants.ID_API_KEY) as! String!
        
        userArray?.add(userDataObject)
        
        return userArray!
    }
    
    func parseDriverDataDictionary(dataDict : NSDictionary) -> NSArray {
        let userArray : NSMutableArray? = NSMutableArray.init()
        
        let driverDataObject : DriverDetailsDataObject = DriverDetailsDataObject()
        
        driverDataObject.userId = dataDict.value(forKey: AppConstants.USER_ID_API_KEY) as! String!
        driverDataObject.lattitide = dataDict.value(forKey: AppConstants.LATTITUDE_API_KEY) as! String!
        driverDataObject.longitude = dataDict.value(forKey: AppConstants.LONGITUDE_API_KEY) as! String!
        driverDataObject.driveDate = dataDict.value(forKey: AppConstants.DRIVE_DATE_API_KEY) as! String!
        driverDataObject.driveTime = dataDict.value(forKey: AppConstants.DRIVE_TIME_API_KEY) as! String!
        driverDataObject.startLocation = dataDict.value(forKey: AppConstants.START_LOCATION_API_KEY) as! String!
        driverDataObject.destination = dataDict.value(forKey: AppConstants.DESTINATION_API_KEY) as! String!
        
        let carDetailsDataObject : CarDetailsDataObject = CarDetailsDataObject()
        carDetailsDataObject.noOfSeats = dataDict.value(forKey: AppConstants.SEATS_AVAILABLE_API_KEY) as! String!
        carDetailsDataObject.chargePerPerson = dataDict.value(forKey: AppConstants.RATE_API_KEY) as! String!
        carDetailsDataObject.carType = dataDict.value(forKey: AppConstants.CAR_TYPE_API_KEY) as! String!
        carDetailsDataObject.carNumber = dataDict.value(forKey: AppConstants.CAR_NUMBER_API_KEY) as! String!
        carDetailsDataObject.carModel = dataDict.value(forKey: AppConstants.CAR_MODEL_API_KEY) as! String!
        carDetailsDataObject.carColor = dataDict.value(forKey: AppConstants.CAR_COLOR_API_KEY) as! String!
        
        driverDataObject.carDetails = carDetailsDataObject
        
        userArray?.add(driverDataObject)
        
        return userArray!
    }
    
    func parseRiderDataDictionary(dataDict : NSDictionary) -> NSArray {
        let userArray : NSMutableArray? = NSMutableArray.init()
        
        let riderDataObject : RiderDetailsDataObject = RiderDetailsDataObject()
        
        riderDataObject.userId = dataDict.value(forKey: AppConstants.USER_ID_API_KEY) as! String!
        riderDataObject.lattitude = dataDict.value(forKey: AppConstants.LATTITUDE_API_KEY) as! String!
        riderDataObject.longitude = dataDict.value(forKey: AppConstants.LONGITUDE_API_KEY) as! String!
        riderDataObject.pickUpTime = dataDict.value(forKey: AppConstants.PICK_UP_TIME_API_KEY) as! String!
        riderDataObject.pickUpDate = dataDict.value(forKey: AppConstants.PICK_UP_DATE_API_KEY) as! String!
        riderDataObject.pickUpLocation = dataDict.value(forKey: AppConstants.PICK_UP_LOCATION_API_KEY) as! String!
        riderDataObject.destination = dataDict.value(forKey: "detination") as! String!
        riderDataObject.profileImageUrl = dataDict.value(forKey: AppConstants.PROFILE_IMAGE_URL_API_KEY) as! String!
        
        userArray?.add(riderDataObject)
        
        return userArray!
    }

}
