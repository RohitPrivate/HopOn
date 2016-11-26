//
//  ServerClass.swift
//  HopOn
//
//  Created by ROHIT SARAF on 11/11/16.
//  Copyright © 2016 AppLives. All rights reserved.
//

import UIKit

class ServerClass: NSObject {
    
    static let sharedInstance = ServerClass()
    
    func performRegisterAction(_ registerURLString : String, _ completion : @escaping (_ success : Bool, _ message : String, _ dataArray : NSArray?) -> Void) {
        
        let session : URLSession = URLSession.shared
        let encodedHost = registerURLString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
    
        let registerURL = URL.init(string: encodedHost!)!
        
        let task : URLSessionTask = session.dataTask(with: registerURL as URL, completionHandler: { (jsonData, response, error) in
            let httpResponse = response as? HTTPURLResponse
    
            if (error != nil) {
                completion(false, error!.localizedDescription, nil)
                return
            }
            
            let sessionData = NSString(data: jsonData!, encoding: String.Encoding.utf8.rawValue)
            print(sessionData ?? "Raw")
            if sessionData?.length != 0 {
                do {
                    let dataDictionary = try JSONSerialization.jsonObject(with: jsonData!, options: [JSONSerialization.ReadingOptions.allowFragments, JSONSerialization.ReadingOptions.mutableLeaves])
                    var description : String? = "Suc cess"
                    var status : Bool = false
                    var dataArray : NSArray? = nil
                    if httpResponse?.statusCode == 200 {
                        description = ((dataDictionary as! NSDictionary).object(forKey: "message") as? String)
                        if description == nil || description?.characters.count == 0 || description == "" {
                            status = true
                            description = "Success"
                            
                            dataArray = DataParser().parseUserDataDictionary(dataDict: dataDictionary as! NSDictionary)
                        }
                        completion(status, description!, dataArray)
                    } else {
                        description = "Server Error"
                        completion(status, description!, dataArray)
                    }
                } catch {
                    print("\(error)")
                }
            }
        })
        task.resume()
    }
    
    func sendVerificationCodeToUserMobile(_ sendVerificationURL : String, _ mobileNumber : String, _ completion : @escaping (_ success : Bool, _ message : String) -> Void) {
        let session : URLSession = URLSession.shared
        let encodedHost = sendVerificationURL.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let sendVerificationURL : URL = URL.init(string: encodedHost!)!
        
        let task = session.dataTask(with: sendVerificationURL, completionHandler: { (jsonData, response, error) in
            let httpResponse = response as? HTTPURLResponse
            
            if (error != nil) {
                completion(false, error!.localizedDescription)
                return
            }
            
            let sessionData = NSString(data: jsonData!, encoding: String.Encoding.utf8.rawValue)
            print(sessionData ?? "Raw")
            
            if sessionData?.length != 0 {
                if httpResponse?.statusCode == 200 {
                    completion(true, sessionData as! String)
                }
            }
        })
        task.resume()
    }
    
    func performLoginAction(_ loginURLString : String, _ completion : @escaping (_ success : Bool, _ message : String, _ dataArray : NSArray?) -> Void) {
        let session : URLSession = URLSession.shared
        let encodedHost = loginURLString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let loginURL : URL = URL.init(string: encodedHost!)!
        
        let task : URLSessionTask = session.dataTask(with: loginURL as URL, completionHandler: { (jsonData, response, error) in
            let httpResponse = response as? HTTPURLResponse
            
            if (error != nil) {
                completion(false, error!.localizedDescription, nil)
                return
            }
            
            let sessionData = NSString(data: jsonData!, encoding: String.Encoding.utf8.rawValue)
            print(sessionData ?? "Raw")
            if sessionData?.length != 0 {
                do {
                    let dataDictionary = try JSONSerialization.jsonObject(with: jsonData!, options: [JSONSerialization.ReadingOptions.allowFragments, JSONSerialization.ReadingOptions.mutableLeaves])
                    var description : String? = "Success"
                    var status : Bool = false
                    var dataArray : NSArray? = nil
                    if httpResponse?.statusCode == 200 {
                        description = ((dataDictionary as! NSDictionary).object(forKey: "message") as? String)
                        if description == nil || description?.characters.count == 0 || description == "" {
                            status = true
                            description = "Success"
                            
                            dataArray = DataParser().parseUserDataDictionary(dataDict: (dataDictionary as! NSDictionary))
                        }
                        completion(status, description!, dataArray)
                    } else {
                        description = "Server Error"
                        completion(status, description!, dataArray)
                    }
                } catch {
                    print("\(error)")
                }
            }
        })
        task.resume()
    }
    
    func performForgotPasswordAction(_ forgotPasswordURLString : String, _ completion : @escaping (_ success : Bool, _ message : String) -> Void) {
        let session : URLSession = URLSession.shared
        let encodedHost = forgotPasswordURLString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        let forgotPasswordURL : URL = URL.init(string: encodedHost!)!
        
        let task : URLSessionTask = session.dataTask(with: forgotPasswordURL as URL, completionHandler: { (jsonData, response, error) in
            let httpResponse = response as? HTTPURLResponse
            
            if (error != nil) {
                completion(false, error!.localizedDescription)
                return
            }
            
            let sessionData = NSString(data: jsonData!, encoding: String.Encoding.utf8.rawValue)
            print(sessionData ?? "Raw")
            if sessionData?.length != 0 {
                do {
                    let dataDictionary = try JSONSerialization.jsonObject(with: jsonData!, options: [JSONSerialization.ReadingOptions.allowFragments, JSONSerialization.ReadingOptions.mutableLeaves])
                    var description : String? = "Error"
                    var status : Bool = false
                    var returnedStatus : String?
                    if httpResponse?.statusCode == 200 {
                        returnedStatus = ((dataDictionary as! NSDictionary).object(forKey: "status") as? String)
                        description = ((dataDictionary as! NSDictionary).object(forKey: "message") as? String)
                        if returnedStatus == "1" {
                            status = true
                            if description == nil || description?.characters.count == 0 || description == "" {
                                description = "Success"
                            }
                        }
                        completion(status, description!)
                    } else {
                        description = "Server Error"
                        completion(status, description!)
                    }
                } catch {
                    print("\(error)")
                }
            }
        })
        task.resume()
    }
    
    func performRegisterActionWithFacebook(_ registerWithFacebookURLString : String, _ completion : @escaping (_ success : Bool, _ message : String, _ dataArray : NSArray?) -> Void) {
        
        let session : URLSession = URLSession.shared
        let encodedHost = registerWithFacebookURLString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        let registerWithFacebookURL = URL.init(string: encodedHost!)!
        
        let task : URLSessionTask = session.dataTask(with: registerWithFacebookURL as URL, completionHandler: { (jsonData, response, error) in
            let httpResponse = response as? HTTPURLResponse
            
            if (error != nil) {
                completion(false, error!.localizedDescription, nil)
                return
            }
            
            let sessionData = NSString(data: jsonData!, encoding: String.Encoding.utf8.rawValue)
            print(sessionData ?? "Raw")
            if sessionData?.length != 0 {
                do {
                    let dataDictionary = try JSONSerialization.jsonObject(with: jsonData!, options: [JSONSerialization.ReadingOptions.allowFragments, JSONSerialization.ReadingOptions.mutableLeaves])
                    var description : String? = "Success"
                    var status : Bool = false
                    var dataArray : NSArray? = nil
                    if httpResponse?.statusCode == 200 {
                        description = ((dataDictionary as! NSDictionary).object(forKey: "message") as? String)
                        if description == nil || description?.characters.count == 0 || description == "" {
                            status = true
                            description = "Success"
                            
                            dataArray = DataParser().parseUserDataDictionary(dataDict: (dataDictionary as! NSDictionary))
                        } else if (((dataDictionary as! NSDictionary).object(forKey: "status") as? String) == "1") {
                            status = true
                            description = "Success"
                            
                            dataArray = DataParser().parseUserDataDictionary(dataDict: (dataDictionary as! NSDictionary))
                        }
                        completion(status, description!, dataArray)
                    } else {
                        description = "Server Error"
                        completion(status, description!, dataArray)
                    }
                } catch {
                    print("\(error)")
                }
            }
        })
        task.resume()
    }
    
    func fetchDriverData(_ driverDataURLString : String, _ completion : @escaping (_ success : Bool, _ message : String, _ dataArray : NSArray?) -> Void) {
        
        let session : URLSession = URLSession.shared
        let encodedHost = driverDataURLString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        let fetchDriverDataURL = URL.init(string: encodedHost!)!
        
        let task : URLSessionTask = session.dataTask(with: fetchDriverDataURL as URL, completionHandler: { (jsonData, response, error) in
            let httpResponse = response as? HTTPURLResponse
            
            if (error != nil) {
                completion(false, error!.localizedDescription, nil)
                return
            }
            
            let sessionData = NSString(data: jsonData!, encoding: String.Encoding.utf8.rawValue)
            print(sessionData ?? "Raw")
            if sessionData?.length != 0 {
                do {
                    let dataDictionary = try JSONSerialization.jsonObject(with: jsonData!, options: [JSONSerialization.ReadingOptions.allowFragments, JSONSerialization.ReadingOptions.mutableLeaves])
                    var description : String? = "Success"
                    var status : Bool = false
                    var dataArray : NSArray! = nil
                    var responseStatus : String?
                    if httpResponse?.statusCode == 200 {
                        description = ((dataDictionary as! NSDictionary).object(forKey: "message") as? String)
                        responseStatus = ((dataDictionary as! NSDictionary).object(forKey: "status") as? String)
                        if responseStatus == "1" {
                            status = true
                            description = "Success"
                            
                            dataArray = DataParser().parseDriverDataDictionary(dataDict: ((((dataDictionary as! NSDictionary).object(forKey: "message")) as? NSDictionary)!.object(forKey: "status") as! NSArray).lastObject as! NSDictionary)
                        }
                        completion(status, description!, dataArray)
                    } else {
                        description = "Server Error"
                        completion(status, description!, dataArray)
                    }
                } catch {
                    print("\(error)")
                }
            }
        })
        task.resume()
    }
    
    func fetchRiderData(_ riderDataURLString : String, _ completion : @escaping (_ success : Bool, _ message : String, _ dataArray : NSArray?) -> Void) {
        
        let session : URLSession = URLSession.shared
        let encodedHost = riderDataURLString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        let fetchRiderDataURL = URL.init(string: encodedHost!)!
        
        let task : URLSessionTask = session.dataTask(with: fetchRiderDataURL as URL, completionHandler: { (jsonData, response, error) in
            let httpResponse = response as? HTTPURLResponse
            
            if (error != nil) {
                completion(false, error!.localizedDescription, nil)
                return
            }
            
            let sessionData = NSString(data: jsonData!, encoding: String.Encoding.utf8.rawValue)
            print(sessionData ?? "Raw")
            if sessionData?.length != 0 {
                do {
                    let dataDictionary = try JSONSerialization.jsonObject(with: jsonData!, options: [JSONSerialization.ReadingOptions.allowFragments, JSONSerialization.ReadingOptions.mutableLeaves])
                    var description : String? = "Success"
                    var status : Bool = false
                    var dataArray : NSArray! = nil
                    if httpResponse?.statusCode == 200 {
                        description = ((dataDictionary as! NSDictionary).object(forKey: "message") as? String)
                        if description == nil || description?.characters.count == 0 || description == "" {
                            status = true
                            description = "Success"
                            
                            dataArray = DataParser().parseRiderDataDictionary(dataDict: ((((dataDictionary as! NSDictionary).object(forKey: "message")) as? NSDictionary)!.object(forKey: "status") as! NSArray).lastObject as! NSDictionary)
                        }
                        completion(status, description!, dataArray)
                    } else {
                        description = "Server Error"
                        completion(status, description!, dataArray)
                    }
                } catch {
                    print("\(error)")
                }
            }
        })
        task.resume()
    }
    
    func performUserVerificationAction(_ userVerificationURLString : String, _ completion : @escaping (_ success : Bool, _ message : String, _ dataArray : NSArray?) -> Void) {
        
        let session : URLSession = URLSession.shared
        let encodedHost = userVerificationURLString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        let fetchRiderDataURL = URL.init(string: encodedHost!)!
        
        let task : URLSessionTask = session.dataTask(with: fetchRiderDataURL as URL, completionHandler: { (jsonData, response, error) in
            let httpResponse = response as? HTTPURLResponse
            
            if (error != nil) {
                completion(false, error!.localizedDescription, nil)
                return
            }
            
            let sessionData = NSString(data: jsonData!, encoding: String.Encoding.utf8.rawValue)
            print(sessionData ?? "Raw")
            if sessionData?.length != 0 {
                do {
                    let dataDictionary = try JSONSerialization.jsonObject(with: jsonData!, options: [JSONSerialization.ReadingOptions.allowFragments, JSONSerialization.ReadingOptions.mutableLeaves])
                    var description : String? = "Success"
                    var status : Bool = false
                    var statusResponse : String?
                    if httpResponse?.statusCode == 200 {
                        description = ((dataDictionary as! NSDictionary).object(forKey: "message") as? String)
                        statusResponse = ((dataDictionary as! NSDictionary).object(forKey: "status") as? String)
                        if (statusResponse == "1" && description == "Inserted successfully") {
                            status = true
                            description = "Success"
                        }
                        
                        completion(status, description!, nil)
                    } else {
                        description = "Server Error"
                        completion(status, description!, nil)
                    }
                } catch {
                    print("\(error)")
                }
            }
        })
        task.resume()
    }
    
    func performUserVerificationCheck(_ userVerificationStatusURLString : String, _ completion : @escaping (_ success : Bool, _ message : String, _ dataArray : NSArray?) -> Void) {
        
        let session : URLSession = URLSession.shared
        let encodedHost = userVerificationStatusURLString.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)
        
        let fetchRiderDataURL = URL.init(string: encodedHost!)!
        
        let task : URLSessionTask = session.dataTask(with: fetchRiderDataURL as URL, completionHandler: { (jsonData, response, error) in
            let httpResponse = response as? HTTPURLResponse
            
            if (error != nil) {
                completion(false, error!.localizedDescription, nil)
                return
            }
            
            let sessionData = NSString(data: jsonData!, encoding: String.Encoding.utf8.rawValue)
            print(sessionData ?? "Raw")
            if sessionData?.length != 0 {
                do {
                    let dataDictionary = try JSONSerialization.jsonObject(with: jsonData!, options: [JSONSerialization.ReadingOptions.allowFragments, JSONSerialization.ReadingOptions.mutableLeaves])
                    var description : String? = "Success"
                    var status : Bool = false
                    var statusResponse : String?
                    if httpResponse?.statusCode == 200 {
                        description = ((dataDictionary as! NSDictionary).object(forKey: "message") as? String)
                        statusResponse = ((dataDictionary as! NSDictionary).object(forKey: "status") as? String)
                        if (statusResponse == "1" && description == "User verified") {
                            status = true
                            description = "Success"
                        }
                        
                        completion(status, description!, nil)
                    } else {
                        description = "Server Error"
                        completion(status, description!, nil)
                    }
                } catch {
                    print("\(error)")
                }
            }
        })
        task.resume()
    }

}
