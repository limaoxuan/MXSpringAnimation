//
//  AudioViewController.swift
//  MXSpringAnimation
//
//  Created by 李茂轩 on 15/4/3.
//  Copyright (c) 2015年 lee. All rights reserved.
//

import UIKit

class AudioViewController: UIViewController {

    // 运动结构体
    struct movement {
        var  movementObject : AnyObject
        var movementLine : String
        var movementName :String
        
    }
    var songList : NSMutableDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioPlayer()
        // Do any additional setup after loading the view.
    }
    
    func audioPlayer(){
        
        var movementArray = [movement]()
        
        songList = NSMutableDictionary()
        
        let backgroundView = UIImageView()
        backgroundView.image = UIImage(named: "background")
        backgroundView.setTranslatesAutoresizingMaskIntoConstraints(false)
        view?.addSubview(backgroundView)
        
        let backgroundViewLocationH = "H:|-0-[backgroundView]-0-|"
        let backgroundViewLocationV = "V:|-0-[backgroundView]-0-|"
        let backgroundViewDic = (["backgroundView":backgroundView]) as NSDictionary
        
        setConstraintsWithStringHandVWithCurrentView(backgroundViewLocationH, backgroundViewLocationV, view!, backgroundViewDic)
        
        
        let arrowView = UIImageView()
        //        arrowView.
        arrowView.image = UIImage(named: "arrow")
        var  size = arrowView.image?.size
        print(size)
        //        image.co
        arrowView.contentMode = UIViewContentMode.ScaleAspectFill
        arrowView.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        view?.addSubview(arrowView)
        setLocationAccrodingWithSuperViewAndCurrentViewSetLayoutAttributeCenterX(view!, arrowView, ">=320@960")
        
        
        //        let arrowViewLocationH = "H:|-5-[arrowView(>=320@960)]"
        let arrowViewLocationH = "H:|-\(2*screenWidth)-[arrowView(>=320@960)]"
        let arrowViewLocationV = "V:|-0-[arrowView]"
        let arrowViewDic = (["arrowView":arrowView]) as NSDictionary
        setConstraintsWithStringHandVWithCurrentView(arrowViewLocationH, arrowViewLocationV, view!, arrowViewDic)
        
        
        let ministryView = UIImageView()
        ministryView.contentMode = UIViewContentMode.ScaleAspectFill
        ministryView.setTranslatesAutoresizingMaskIntoConstraints(false)
        ministryView.image = UIImage(named: "ministry")
        view?.addSubview(ministryView)
        
        
        
        
        setLocationAccrodingWithSuperViewAndCurrentViewSetLayoutAttributeCenterX(view!, ministryView, ">=320@960")
        let ministryLocationH = "H:|-\(2*screenWidth)-[ministryView(>=320@960)]"
        let ministryLocationY = "V:|-80-[ministryView]"
        let ministryDic = (["ministryView":ministryView]) as NSDictionary
        setConstraintsWithStringHandVWithCurrentView(ministryLocationH, ministryLocationY, view!, ministryDic)
        
        let addButton = UIButton()
        addButton.contentMode = UIViewContentMode.ScaleAspectFill
        addButton.setTranslatesAutoresizingMaskIntoConstraints(false)
        addButton.setImage(UIImage(named: "add-button"), forState: UIControlState.Normal)
        addButton.setImage(UIImage(named: "add-button-pressed"), forState: UIControlState.Highlighted)
        view?.addSubview(addButton)
        setLocationAccrodingWithSuperViewAndCurrentViewSetLayoutAttributeCenterX(view!, addButton, ">=320@960")
        
        let addButtonLocationH = "H:|-\(2*screenWidth)-[addButton(>=320@960)]"
        let addButtonLocationY = "V:|-120-[addButton]"
        let addButtonDic = (["addButton":addButton]) as NSDictionary
        setConstraintsWithStringHandVWithCurrentView(addButtonLocationH, addButtonLocationY, view!, addButtonDic)
        
        
        
        var imageNameArray : [String] = ["1st-row","2nd-row","3rd-row","4th-row","5th-row"]
        accrodingArrayInitSongsList(imageNameArray)
        
        
        
        
        
        let   arrowViewMovement = movement(movementObject: arrowView, movementLine: "H:|-5-[arrowView(>=320@960)]",movementName:"arrowView")
        movementArray.append(arrowViewMovement)
        
        let ministryViewMovement = movement(movementObject: ministryView, movementLine: "H:|-0-[ministryView(>=320@960)]", movementName: "ministryView")
        movementArray.append(ministryViewMovement)
        
        let addButtonMovement = movement(movementObject: addButton, movementLine: "H:|-0-[addButton(>=320@960)]", movementName: "addButton")
        movementArray.append(addButtonMovement)
        
        for i in 1...imageNameArray.count {
            
            let imageView = view?.viewWithTag(i)
            
            
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
                
                
                setConstraintsWithStringWithCurrentView(someObjectMovement.movementLine, self.view, [someObjectMovement.movementName:someObjectMovement.movementObject])
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
        view?.addSubview(someRow)
        
        
        someRowDic = Dictionary()
        // 第一次
        if(songList.count == 0 ){
            someRowDic = [imageName : someRow]
            
            someRowDic["currentImage"] =  someRow
            someRowLocationY = "V:|-190-[currentImage]"
            
        }else
        {
            //        第二次
            
            
            someRowDic["currentImage"] = someRow
            someRowDic["lastImageName"] = songList.allValues.last as? UIImageView
            someRowLocationY = "V:[lastImageName]-0-[currentImage]"
            
            
        }
        songList.setObject(someRow, forKey: "imageName")
        
        someRowLocationH = "H:|-\(screenWidth)-[currentImage(>=\(screenWidth)@960)]"
        
        
        setConstraintsWithStringHandVWithCurrentView(someRowLocationH, someRowLocationY, view!, someRowDic  )
        
        
        
        
        
        
        
        
        
        
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
