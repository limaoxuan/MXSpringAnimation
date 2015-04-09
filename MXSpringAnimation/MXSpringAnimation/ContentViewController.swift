//
//  ContentViewController.swift
//  MXSpringAnimation
//
//  Created by 李茂轩 on 15/4/3.
//  Copyright (c) 2015年 lee. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    override func viewWillAppear(animated: Bool) {
         self.view.backgroundColor = UIColor.blackColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        startAnimation()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startAnimation(){
        
        
        let myView = UIView()
        myView.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(myView)
        setLocationCurrentInSuperViewlocationCenter(view , myView, "300", "300")
        
        
        myView.layoutIfNeeded()
        
        let image = UIImage(named: "起始图片")
       myView.contentMode = UIViewContentMode.ScaleAspectFill
        myView.layer.masksToBounds = true
        myView.layer.contents = image?.CGImage
        
        
        
        
        let image2 = UIImage(named: "结束图片")
        let mapViewYDic = ["newImage":image2!,"x":0,"y":0,"width":myView.frame.width/2,"height":myView.frame.height/2]
        
        MXSpringAnimation.sharedMXSpringAnimation.MXShowAnimation(myView, type: AnimationType.Content, obj: mapViewYDic) { (finished) -> Void in
            
        }
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
