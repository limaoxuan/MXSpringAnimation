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
    
    
    
// 运动结构体
    struct movement {
      var  movementObject : AnyObject
        var movementLine : String
        var movementName :String
        
    }
    
    var imageLayer : CALayer!
    var window: UIWindow?
    var appBackground : UIImageView?
    var mapView : UIImageView?
    var mapShowStatus : Bool = false
    var songList : NSMutableDictionary !
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        self.window?.backgroundColor = UIColor.whiteColor()
        
        self.window?.makeKeyAndVisible()
        
//        var backgroundView = uim
       

        
        
        startAnimation()
        // second animation
//        audioPlayer()
        

        return true
    }
    
    
    
    func startAnimation(){
    
    
    
        let image = UIImage(named: "起始图片")
        self.window?.contentMode = UIViewContentMode.ScaleAspectFill
        self.window?.layer.masksToBounds = true
        self.window?.layer.contents = image?.CGImage
        
        
        
        let image2 = UIImage(named: "结束图片")
        let mapViewYDic = ["newImage":image2!,"x":0,"y":0,"width":screenWidth/2,"height":screenWidth/2]
        
        
        MXShowAnimation(self.window!, AnimationType.Content, mapViewYDic)

    }

    
    
    
    
    func audioPlayer(){
    
    var movementArray = [movement]()
    
    songList = NSMutableDictionary()
    
        let backgroundView = UIImageView()
        backgroundView.image = UIImage(named: "background")
        backgroundView.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.window?.addSubview(backgroundView)
        
        let backgroundViewLocationH = "H:|-0-[backgroundView]-0-|"
        let backgroundViewLocationV = "V:|-0-[backgroundView]-0-|"
        let backgroundViewDic = (["backgroundView":backgroundView]) as NSDictionary
        
        setConstraintsWithStringHandVWithCurrentView(backgroundViewLocationH, backgroundViewLocationV, self.window!, backgroundViewDic)
        
        
        let arrowView = UIImageView()
//        arrowView.
        arrowView.image = UIImage(named: "arrow")
        var  size = arrowView.image?.size
        print(size)
//        image.co
        arrowView.contentMode = UIViewContentMode.ScaleAspectFill
        arrowView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        self.window?.addSubview(arrowView)
        setLocationAccrodingWithSuperViewAndCurrentViewSetLayoutAttributeCenterX(self.window!, arrowView, ">=320@960")
        
        
//        let arrowViewLocationH = "H:|-5-[arrowView(>=320@960)]"
         let arrowViewLocationH = "H:|-\(2*screenWidth)-[arrowView(>=320@960)]"
        let arrowViewLocationV = "V:|-0-[arrowView]"
        let arrowViewDic = (["arrowView":arrowView]) as NSDictionary
        setConstraintsWithStringHandVWithCurrentView(arrowViewLocationH, arrowViewLocationV, self.window!, arrowViewDic)
        
        
        let ministryView = UIImageView()
        ministryView.contentMode = UIViewContentMode.ScaleAspectFill
        ministryView.setTranslatesAutoresizingMaskIntoConstraints(false)
        ministryView.image = UIImage(named: "ministry")
        self.window?.addSubview(ministryView)
        
        
        
        
    setLocationAccrodingWithSuperViewAndCurrentViewSetLayoutAttributeCenterX(self.window!, ministryView, ">=320@960")
        let ministryLocationH = "H:|-\(2*screenWidth)-[ministryView(>=320@960)]"
        let ministryLocationY = "V:|-56-[ministryView]"
        let ministryDic = (["ministryView":ministryView]) as NSDictionary
        setConstraintsWithStringHandVWithCurrentView(ministryLocationH, ministryLocationY, self.window!, ministryDic)

        let addButton = UIButton()
        addButton.contentMode = UIViewContentMode.ScaleAspectFill
        addButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        addButton.setImage(UIImage(named: "add-button"), forState: UIControlState.Normal)
        addButton.setImage(UIImage(named: "add-button-pressed"), forState: UIControlState.Highlighted)
        self.window?.addSubview(addButton)
        setLocationAccrodingWithSuperViewAndCurrentViewSetLayoutAttributeCenterX(self.window!, addButton, ">=320@960")
        
        let addButtonLocationH = "H:|-\(2*screenWidth)-[addButton(>=320@960)]"
        let addButtonLocationY = "V:|-102-[addButton]"
        let addButtonDic = (["addButton":addButton]) as NSDictionary
        setConstraintsWithStringHandVWithCurrentView(addButtonLocationH, addButtonLocationY, self.window!, addButtonDic)


        
        var imageNameArray : [String] = ["1st-row","2nd-row","3rd-row","4th-row","5th-row"]
        accrodingArrayInitSongsList(imageNameArray)
        
        
    
        
        
        let   arrowViewMovement = movement(movementObject: arrowView, movementLine: "H:|-5-[arrowView(>=320@960)]",movementName:"arrowView")
        movementArray.append(arrowViewMovement)
        
        let ministryViewMovement = movement(movementObject: ministryView, movementLine: "H:|-0-[ministryView(>=320@960)]", movementName: "ministryView")
        movementArray.append(ministryViewMovement)

        let addButtonMovement = movement(movementObject: addButton, movementLine: "H:|-0-[addButton(>=320@960)]", movementName: "addButton")
        movementArray.append(addButtonMovement)
        
        for i in 1...imageNameArray.count {
            
            let imageView = self.window?.viewWithTag(i)
            
            
            let anyBodyImageMovement = movement(movementObject: imageView!, movementLine: "H:|-0-[currentImage(>=\(screenWidth)@960)]", movementName: "currentImage")
            movementArray.append(anyBodyImageMovement)
            
        }
        
        
        
        
        animationStart(movementArray)
    }
    
    func animationStart(array: [movement]){
                var initDelay = 1.0
        //
                let stutter = 0.15
        //
                let duration = 1.1
        
        for i in 0...array.count-1 {
        
        
        
            let   someObjectMovement =  array[i] as movement
        
                    someObjectMovement.movementObject.layoutIfNeeded()
        
                    UIView.animateWithDuration(duration, delay: initDelay, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.allZeros, animations: { () -> Void in
            
                        
                        setConstraintsWithStringWithCurrentView(someObjectMovement.movementLine, self.window!, [someObjectMovement.movementName:someObjectMovement.movementObject])
                         someObjectMovement.movementObject.layoutIfNeeded()
            
                        
                        initDelay += stutter
                    }, completion: nil)
        
        
        
        }
    
    
    
    
    }
    
    func accrodingArrayInitSongsList(imageArray:[String]){
    

        for i in 0...imageArray.count-1 {
        
        accrodingImageNameInitSongList(imageArray[i],index: Int(i+1))
        
        
        
        }

    
    }
    
    
    
    func accrodingImageNameInitSongList(imageName : String,index :Int){
        
        
        
        
        var someRowDic : Dictionary<String,UIImageView>!
        var someRowLocationH : String!
        var someRowLocationY : String!
        let imageName = imageName as String
        let someRow = UIImageView()
        
        
        someRow.image = UIImage(named: imageName)
        someRow.tag =  index
        someRow.setTranslatesAutoresizingMaskIntoConstraints(false)
        someRow.contentMode = UIViewContentMode.ScaleAspectFill
        self.window?.addSubview(someRow)
        

        someRowDic = Dictionary()
        // 第一次
        if(songList.count == 0 ){
         someRowDic = [imageName : someRow]
            
            someRowDic["currentImage"] =  someRow
         someRowLocationY = "V:|-170-[currentImage]"
            
        }else
        {
//        第二次
        
            
            someRowDic["currentImage"] = someRow
            someRowDic["lastImageName"] = songList.allValues.last as? UIImageView
             someRowLocationY = "V:[lastImageName]-0-[currentImage]"
           
        
        }
        songList.setObject(someRow, forKey: "imageName")

         someRowLocationH = "H:|-\(screenWidth)-[currentImage(>=\(screenWidth)@960)]"
        
        
        setConstraintsWithStringHandVWithCurrentView(someRowLocationH, someRowLocationY, self.window!, someRowDic  )

        
        
        
        
        
        
        
        
    
    
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
            MXShowAnimation(self.appBackground!, AnimationType.NormalScale,scaleZoomInMapView)
            
            // 地图视图代码
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                self.mapView!.alpha = 0
            }, completion: nil)
        
            let mapViewScaleZoomOutDic = ["toScale":0.9,"fromScale":1.0] as NSDictionary
            
            self.mapView!.layoutIfNeeded()
         
            MXShowAnimation(self.mapView!, AnimationType.NormalScale,mapViewScaleZoomOutDic)
            self.mapView!.layoutIfNeeded()
            //            self.mapView!.layer.removeAllAnimations()
            let mapViewYDic = ["toValue":10,"fromValue":-10] as NSDictionary
            MXShowAnimation(self.mapView!, AnimationType.NormalY, mapViewYDic)

            
            
            
        } else {
        
           
        mapShowStatus = true
        UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.appBackground?.alpha = 0.3
        }, completion: nil)
            self.appBackground!.layoutIfNeeded()
//            self.appBackground!.layer.removeAllAnimations()
            let scaleAppBackgroundDic = ["toScale":0.9,"fromScale":1.0] as NSDictionary
          MXShowAnimation(self.appBackground!, AnimationType.NormalScale,scaleAppBackgroundDic)
        UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.mapView!.alpha = 1
        }, completion: nil)
             let mapViewScaleDic = ["toScale":1.0,"fromScale":0.9] as NSDictionary
            
            self.mapView!.layoutIfNeeded()
            
            MXShowAnimation(self.mapView!, AnimationType.NormalScale,mapViewScaleDic)
            
//            self.mapView!.layer.removeAllAnimations()
            let mapViewYDic = ["toValue":-10,"fromValue":10] as NSDictionary
            MXShowAnimation(self.mapView!, AnimationType.NormalY, mapViewYDic)
            
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
        return urls[urls.count-1] as! NSURL
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

