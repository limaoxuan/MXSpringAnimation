//
//  AppDelegate.swift
//  MXSpringAnimation
//
//  Created by 李茂轩 on 15/2/15.
//  Copyright (c) 2015年 lee. All rights reserved.
//

import UIKit
import CoreData
import Foundation

let appBackgroundTopDistance  : CGFloat = 20
let mapViewTopDistance : CGFloat = 92
let iconWith :CGFloat = 49
let iconHeight :CGFloat = 44
let iconTopDistance :CGFloat = 19



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    

    
    var imageLayer : CALayer!
    var maskLayer : CALayer!
    
    var imageContents : UIImage!
    var maskContents : UIImage!
    
    var window: UIWindow?
    var appBackground : UIImageView?
    var mapView : UIImageView?
    var mapShowStatus : Bool = false

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
//        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
//        
//        self.window?.backgroundColor = UIColor.whiteColor()
//        
//        self.window?.makeKeyAndVisible()
        
//        var backgroundView = uim
       

        
        
//        startAnimation()
        // second animation
//        audioPlayer()
        initMaskAnimation()
      


        return true
    }
    
   func initMaskAnimation(){
    
    
    
    
    
    self.window?.backgroundColor  = UIColor.blackColor()
    
    self.imageContents = UIImage(named: "girl")
    self.maskContents  = UIImage(named: "maskLayerContents")
    
    self.imageLayer                  =  CALayer()
    self.imageLayer.frame            =  CGRectMake(90, 220, 200, 200)
    self.imageLayer.contents         =  self.imageContents.CGImage
    self.window?.contentMode         =  UIViewContentMode.ScaleAspectFill
    self.window?.layer.masksToBounds =  true
    self.window?.layer.addSublayer(self.imageLayer)
    
    self.maskLayer                   =  CALayer()
    self.maskLayer.frame             =  CGRectMake(-100, 0, 200,200)
    self.maskLayer.contents = self.maskContents.CGImage
    self.imageLayer.mask = self.maskLayer
    
    let  delayInSeconds = 2.0;
    
    var minutes = 1 * Double(NSEC_PER_SEC)
    
    var dtime = dispatch_time(DISPATCH_TIME_NOW, Int64(minutes))
    dispatch_after(dtime, dispatch_get_main_queue()) { () -> Void in
        
        
        
        self.maskLayerAnimation()
        
    }
    
    
    }
    
    func maskLayerAnimation(){
    
//        let oldBounds = CGRectMake(100, 0, 200,200)
        
        print()
        
        let newBounds = CGRectMake(-100, 0, 200,200)
        
       let maskAnimation = CABasicAnimation(keyPath: "bounds")
        
        maskAnimation.fromValue = NSValue(CGRect: self.maskLayer.bounds)
        maskAnimation.toValue = NSValue(CGRect: newBounds)
        maskAnimation.duration = 1.0
        maskAnimation.autoreverses = false
        maskAnimation.removedOnCompletion = false
        maskAnimation.fillMode = kCAFillModeForwards
        self.imageLayer.addAnimation(maskAnimation, forKey: "mask")


    
    }
    
    
    
   
    
    
    
    
       
      
        
    
    
    
    func didTapIcon(sender:UIButton){
        if mapShowStatus {
            
            self.appBackground!.layoutIfNeeded()
//            self.appBackground!.layer.removeAllAnimations()
//            self.mapView?.layer.removeAllAnimations()
//        // 隐藏地图
            mapShowStatus = false
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.appBackground!.alpha = 1
            }, completion: nil)
            self.appBackground!.layoutIfNeeded()
            
            let scaleZoomInMapView = ["toScale":1.0,"fromScale":0.9] as NSDictionary
//            MXShowAnimation(self.appBackground!, AnimationType.NormalScale,scaleZoomInMapView)
            
            MXSpringAnimation.sharedMXSpringAnimation.MXShowAnimation(self.appBackground!, type: AnimationType.NormalScale, obj: scaleZoomInMapView) { (finished) -> Void in
                
                }

            
            
            
            // 地图视图代码
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.mapView!.alpha = 0
            }, completion: nil)
        
            let mapViewScaleZoomOutDic = ["toScale":0.9,"fromScale":1.0] as NSDictionary
            
            self.mapView!.layoutIfNeeded()
         
            
            
            MXSpringAnimation.sharedMXSpringAnimation.MXShowAnimation(self.mapView!, type: AnimationType.NormalScale, obj: mapViewScaleZoomOutDic) { (finished) -> Void in
                
            }
            
            
            self.mapView!.layoutIfNeeded()
            //            self.mapView!.layer.removeAllAnimations()
            let mapViewYDic = ["toValue":10,"fromValue":-10] as NSDictionary
            
            MXSpringAnimation.sharedMXSpringAnimation.MXShowAnimation(self.mapView!, type: AnimationType.NormalY, obj: mapViewYDic) { (finished) -> Void in
                
            }

            
       

            
            
            
        } else {
        
           
        mapShowStatus = true
//            UIView.animateWithDuration(<#duration: NSTimeInterval#>, animations: <#() -> Void##() -> Void#>)
            
//            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
//                
//            }, completion: nil)
            
            
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            
            
           self.appBackground!.alpha = 0.3
            
            
            
            
            
        }, completion: nil)
            
            self.appBackground!.layoutIfNeeded()
//            self.appBackground!.layer.removeAllAnimations()
            let scaleAppBackgroundDic = ["toScale":0.9,"fromScale":1.0] as NSDictionary
            
            
            MXSpringAnimation.sharedMXSpringAnimation.MXShowAnimation(self.appBackground!, type: AnimationType.NormalScale, obj: scaleAppBackgroundDic) { (finished) -> Void in
                
            }
  
            
          
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.mapView!.alpha = 1
        }, completion: nil)
             let mapViewScaleDic = ["toScale":1.0,"fromScale":0.9] as NSDictionary
            
            self.mapView!.layoutIfNeeded()
            
            MXSpringAnimation.sharedMXSpringAnimation.MXShowAnimation(self.mapView!, type: AnimationType.NormalScale, obj: mapViewScaleDic) { (finished) -> Void in
                
            }

            
            
            
//            self.mapView!.layer.removeAllAnimations()
            let mapViewYDic = ["toValue":-10,"fromValue":10] as NSDictionary
            
            
            
            MXSpringAnimation.sharedMXSpringAnimation.MXShowAnimation(self.mapView!, type: AnimationType.NormalY, obj: mapViewYDic) { (finished) -> Void in
                
            }
           
            
        }
    
    
    
    
    }
    
    func mapExample(){
    
    
        appBackground = UIImageView()
        appBackground?.image = UIImage(named: "app-bg")
        appBackground?.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.window?.addSubview(appBackground!)
        
        let appBackgroundLocationH = "H:|-0-[appBackground]-0-|"
        let appBackgroundLocationV = "V:|-\(appBackgroundTopDistance)-[appBackground(\(screenHeight-appBackgroundTopDistance))]"
        let appBackgroundViewDic = (["appBackground":appBackground!]) as NSDictionary
        setConstraintsWithStringHandVWithCurrentView(appBackgroundLocationH, appBackgroundLocationV, self.window!, appBackgroundViewDic)
        
        
        mapView = UIImageView()
        mapView?.image = UIImage(named: "map-arrow")
        mapView?.setTranslatesAutoresizingMaskIntoConstraints(false)
        mapView?.alpha = 0
        self.window?.addSubview(mapView!)
        
        let mapViewLocationH = "H:|-0-[mapView]-0-|"
        let mapViewLocationV = "V:|-\(mapViewTopDistance)-[mapView(\(screenHeight-mapViewTopDistance))]"
        let mapViewDic = (["mapView":mapView!]) as NSDictionary
        
        setConstraintsWithStringHandVWithCurrentView(mapViewLocationH, mapViewLocationV, self.window!, mapViewDic)
        mapView?.transform = CGAffineTransformMakeScale(0.9, 0.9)
        //            CGAffineTransformScale(mapView!.transform, 0.8, 0.8)
        
        
        
        let icon = UIButton()
        icon.setImage(UIImage(named: "map-icon"), forState: UIControlState.Normal)
        icon.setTranslatesAutoresizingMaskIntoConstraints(false)
        icon.addTarget(self, action: "didTapIcon:", forControlEvents: UIControlEvents.TouchUpInside)
        self.window?.addSubview(icon)
        
        let iconLocationH = "H:|-\(screenWidth-iconWith)-[icon(\(iconWith))]"
        let iconLocationV = "V:|-\(iconTopDistance)-[icon(\(iconHeight))]"
        let iconButtonDic = (["icon":icon]) as NSDictionary
        setConstraintsWithStringHandVWithCurrentView(iconLocationH, iconLocationV, self.window!, iconButtonDic)

    
    
    
    
    
    }
    

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
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file. This code uses a directory named "com.lee.MXSpringAnimation" in the application's documents Application Support directory.
        let urls = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        return urls[urls.count-1] as NSURL
    }()

    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
        let modelURL = NSBundle.mainBundle().URLForResource("MXSpringAnimation", withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()

    lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
        // Create the coordinator and store
        var coordinator: NSPersistentStoreCoordinator? = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.URLByAppendingPathComponent("MXSpringAnimation.sqlite")
        var error: NSError? = nil
        var failureReason = "There was an error creating or loading the application's saved data."
        if coordinator!.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil, error: &error) == nil {
            coordinator = nil
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data"
            dict[NSLocalizedFailureReasonErrorKey] = failureReason
            dict[NSUnderlyingErrorKey] = error
            error = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            // Replace this with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog("Unresolved error \(error), \(error!.userInfo)")
            abort()
        }
        
        return coordinator
    }()

    lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
        let coordinator = self.persistentStoreCoordinator
        if coordinator == nil {
            return nil
        }
        var managedObjectContext = NSManagedObjectContext()
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if let moc = self.managedObjectContext {
            var error: NSError? = nil
            if moc.hasChanges && !moc.save(&error) {
                // Replace this implementation with code to handle the error appropriately.
                // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                NSLog("Unresolved error \(error), \(error!.userInfo)")
                abort()
            }
        }
    }

}

