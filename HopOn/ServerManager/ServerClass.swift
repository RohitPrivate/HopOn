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
    
    func performRegisterAction(_ registerURLString : String, _ completion : @escaping (_ success : Bool, _ message : String) -> Void) {
        
        let session : URLSession = URLSession.shared
        let registerURL : URL = URL.init(string: registerURLString)!
        
        let task : URLSessionTask = session.dataTask(with: registerURL as URL, completionHandler: { (jsonData, response, error) in
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
                    var description : String? = "Success"
                    var status : Bool = false
                    if httpResponse?.statusCode == 200 {
                        description = ((dataDictionary as! NSDictionary).object(forKey: "message") as? String)
                        if description == nil || description?.characters.count == 0 || description == "" {
                            status = true
                            description = "Success"
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
    
    func sendVerificationCodeToUserMobile(_ sendVerificationURL : String, _ mobileNumber : String, _ completion : @escaping (_ success : Bool, _ message : String) -> Void) {
        let session : URLSession = URLSession.shared
        let sendVerificationURL : URL = URL.init(string: sendVerificationURL)!
        
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
    
    func performLoginAction(_ loginURLString : String, _ completion : @escaping (_ success : Bool, _ message : String) -> Void) {
        let session : URLSession = URLSession.shared
        let loginURL : URL = URL.init(string: loginURLString)!
        
        let task : URLSessionTask = session.dataTask(with: loginURL as URL, completionHandler: { (jsonData, response, error) in
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
                    var description : String? = "Success"
                    var status : Bool = false
                    if httpResponse?.statusCode == 200 {
                        description = ((dataDictionary as! NSDictionary).object(forKey: "message") as? String)
                        if description == nil || description?.characters.count == 0 || description == "" {
                            status = true
                            description = "Success"
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

}
