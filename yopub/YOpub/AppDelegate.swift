//
//  AppDelegate.swift
//  YoPub!
//
//  Created by Justin Platz on 5/20/15.
//  Copyright (c) 2015 ioJP. All rights reserved.
//

import UIKit
import CloudKit



@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate, UIAlertViewDelegate, PNObjectEventListener {
    
    var window: UIWindow?
    var apnsID: NSString?
    var dToken: NSData? {
        didSet {
            self.baseViewController?.tokenID = dToken
            println("Token id is getting set to ")
            println(dToken)

        }
    }
    var baseViewController: ViewController?
    var client:PubNub?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        Parse.setApplicationId("GD3ntgZ5gyAKlWugeLZJzwbrgkyTwOZ9sEesVqOv",
            clientKey: "z1ZI3oDA6SwhnepNWg0CXy6f5ljHdmTQW1kQyd2H")
        
        var navController = window!.rootViewController! as! UINavigationController
        self.baseViewController = navController.viewControllers[0] as? ViewController;
        
        
        
        
        if (application.respondsToSelector("isRegisteredForRemoteNotifications"))
        {
            // iOS 8 Notifications
            application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes: (.Badge | .Sound | .Alert), categories: nil));
            application.registerForRemoteNotifications()
        }
        else
        {
            // iOS < 8 Notifications
            application.registerForRemoteNotificationTypes(.Badge | .Sound | .Alert)
        }
        
        
        


        
        
        
        return true
    }
    

    func application(application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        let tokenChars = UnsafePointer<CChar>(deviceToken.bytes)
        var tokenString = ""
        
        for var i = 0; i < deviceToken.length; i++ {
            tokenString += String(format: "%02.2hhx", arguments: [tokenChars[i]])
        }
        
        println("My Device Token is: \(tokenString)")
        apnsID = tokenString
        println("The dtoken is being set to ", deviceToken)
        dToken = deviceToken
    }
    
    
    func application(application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        println("The didfailtoregister error is:")
        println(error)
    }

    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {

        var message: NSString = ""
        var alert: AnyObject? = userInfo["aps"]
        if((alert?.isKindOfClass(NSString)) != nil){
            //message = (alert as! AnyObject? as? String)!
            message = userInfo["aps"]!.objectForKey("alert") as AnyObject? as! String
        }
        else if((alert?.isKindOfClass(NSDictionary)) != nil){
            message = alert!.objectForKey("alert")! as! NSString as! String
        }

        if((alert) != nil){

            var alert = UIAlertView()
            alert.title = message as String
            
            println("Printing the aps ")
            println(userInfo["aps"]!.objectForKey("alert"))
            println("Printing the name ")
            println(userInfo["alert"] )
            
            alert.message = "YO"
            alert.addButtonWithTitle("OK")
            alert.show()
        }
    }
//
//    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
//
//            println("A new record is generated and we received a push")
//
//            let notification = CKNotification(
//                fromRemoteNotificationDictionary: userInfo)
//
//            if let query = notification as? CKQueryNotification{
//                let model = query.recordFields["alert"] as? NSString as? String
//                if let theModel = model{
//                    println("The model of the newly inserted car is \(theModel)")
//                }
//
//            }
//
//    }



    

    
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
    func client(client: PubNub!, didReceiveMessage message: PNResult!, withStatus status: PNStatus!) {
        if((status) != nil){
        
        }
        else if((message) != nil){
            println("I got a message from didreceivemessage! it is: ")
            println(message.data!)

        }
        
    }
    
    
    
}
