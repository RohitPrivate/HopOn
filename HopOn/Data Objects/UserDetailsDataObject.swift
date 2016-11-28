//
//  UserDetailsDataObject.swift
//  HopOn
//
//  Created by ROHIT SARAF on 22/11/16.
//  Copyright © 2016 AppLives. All rights reserved.
//

import UIKit

class UserDetailsDataObject: NSObject, NSCoding {
    
    var name : String!
    var email : String!
    var password : String!
    var mobile : String!
    var streetAddress : String!
    var profileImageUrl : String!
    var city : String!
    var country : String!
    var organization : String!
    var userId : String!
    var deviceId : String!
    var deviceType : String!
    var id : String!
    
    init(name : String, email : String, password : String, mobile : String, streetAddress : String, profileImageUrl : String, city : String, country : String, organization : String, userId : String, deviceId : String, deviceType : String, id : String) {
        self.name = name
        self.email = email
        self.password = password
        self.mobile = mobile
        self.streetAddress = streetAddress
        self.profileImageUrl = profileImageUrl
        self.city = city
        self.country = country
        self.organization = organization
        self.userId = userId
        self.deviceId = deviceId
        self.deviceType = deviceType
        self.id = id
        
    }
    
    required convenience init(coder aDecoder:NSCoder) {
        let name : String = aDecoder.decodeObject(forKey: "name") as! String
        let email : String = aDecoder.decodeObject(forKey: "email") as! String
        let password : String = aDecoder.decodeObject(forKey: "password") as! String
        let mobile : String = aDecoder.decodeObject(forKey: "mobile") as! String
        let streetAddress : String = aDecoder.decodeObject(forKey: "streetAddress") as! String
        let profileImageUrl : String = aDecoder.decodeObject(forKey: "profileImageUrl") as! String
        let city : String = aDecoder.decodeObject(forKey: "city") as! String
        let country : String = aDecoder.decodeObject(forKey: "country") as! String
        let organization : String = aDecoder.decodeObject(forKey: "organization") as! String
        let userId : String = aDecoder.decodeObject(forKey: "userId") as! String
        let deviceId : String = aDecoder.decodeObject(forKey: "deviceId") as! String
        let deviceType : String = aDecoder.decodeObject(forKey: "deviceType") as! String
        let id : String = aDecoder.decodeObject(forKey: "id") as! String
        
        self.init(name: name, email: email, password: password, mobile: mobile, streetAddress: streetAddress, profileImageUrl: profileImageUrl, city: city, country: country, organization: organization, userId: userId, deviceId: deviceId, deviceType: deviceType, id: id)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(mobile, forKey: "mobile")
        aCoder.encode(streetAddress, forKey: "streetAddress")
        aCoder.encode(profileImageUrl, forKey: "profileImageUrl")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(country, forKey: "country")
        aCoder.encode(organization, forKey: "organization")
        aCoder.encode(userId, forKey: "userId")
        aCoder.encode(deviceId, forKey: "deviceId")
        aCoder.encode(deviceType, forKey: "deviceType")
        aCoder.encode(id, forKey: "id")
    }
    
}
