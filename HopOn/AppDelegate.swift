//
//  AppDelegate.swift
//  HopOn
//
//  Created by ROHIT SARAF on 04/11/16.
//  Copyright © 2016 AppLives. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //Delay to display the splash screen for a longer time
        Thread.sleep(forTimeInterval:3.0)
        
//        if UserDefaults.standard.bool(forKey: AppConstants.SHOULD_STAY_LOGGED_IN) {
//            let mainStoryBoard : UIStoryboard? = UIStoryboard(name: "Main", bundle: nil)
//            let rootViewController : UIViewController? = mainStoryBoard?.instantiateViewController(withIdentifier: "SWRevealViewController")
//            UIApplication.shared.keyWindow?.rootViewController = rootViewController
//        }
        
        return true
    }
    
    //Function created to parse the given country list. Useless now.
    func createCountryDataPList() {
        if let path = Bundle.main.path(forResource: "CountryCodes", ofType: "txt"){
            
            do {
            let content = try String.init(contentsOf: URL.init(fileURLWithPath: path), encoding: String.Encoding.utf8)
                let lines : [String] = content.components(separatedBy: "\r\n")
                print(lines)
                let array : NSMutableArray = NSMutableArray()
                for var string in lines as NSArray {
                    string = (string as! String).replacingOccurrences(of: "<item>", with: "")
                    string = (string as! String).replacingOccurrences(of: "</item>", with: "")
                    string = (string as! String).replacingOccurrences(of: " ", with: "")
                    let objects : [String] = (string as AnyObject).components(separatedBy: ",")
                    array.add(objects)
                }
                if array.count > 0 {
                    let paths : String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
                    let path = paths.appending("CountryList.plist")
                    let fileManager = FileManager.default
                    if (!(fileManager.fileExists(atPath: path)))
                    {
                        let bundle : String? = Bundle.main.path(forResource: "CountryList", ofType: "plist")
                        array.write(toFile: bundle!, atomically: true)
                        //try fileManager.copyItem(atPath: bundle! as String, toPath: path)
                    }
                    //let data : NSDictionary? = NSDictionary.init()
                    
                    //data?.setValue(array, forKey: "object")
                    //data?.write(toFile: path, atomically: true)
                }
            } catch {
                
            }
        }
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

