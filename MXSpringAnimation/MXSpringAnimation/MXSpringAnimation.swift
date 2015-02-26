//
//  MXAnimation.swift
//  MXAlertView
//
//  Created by 李茂轩 on 15/2/10.
//  Copyright (c) 2015年 lee. All rights reserved.
//

import UIKit

public enum AnimationType{
   
    case ElasticScale // This type can Elastic zoom in or Elastic zoom out
    case NormalScale  // This is a normal scale animation
    case NormalY
    case NormalX
    

}





func MXShowAnimation(currentView:UIView,type:AnimationType,obj: NSDictionary){
//    nso
    
    switch type {
    case .ElasticScale :
      elasticScaleShowAnimation(currentView)
    case .NormalScale:
  
        nomalScaleAnimation(currentView,obj)
    case .NormalY:
        print("")
        nomalYAnimation(currentView, obj)
        
    default:
        break
        
    
    
    
    
    }
    
    
    



}

func MXDismissAnimation(currentView:UIView,type:AnimationType){


    switch type {
    case .ElasticScale :
        elasticScaleDissmissAnimation(currentView)
    default:
        break

    
    
    
    }




}

func nomalYAnimation(currentView:UIView,obj : NSDictionary){

let layerPosition = currentView.layer.position
    
    print(layerPosition.y)
    
    
    
    let keyframeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
    let toValue = obj.objectForKey("toValue") as! CGFloat
    
    let fromValue = obj.objectForKey("fromValue") as! CGFloat
    keyframeAnimation.values = [fromValue,toValue]
    keyframeAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear),CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)]
    keyframeAnimation.keyTimes = [0,1.0]
    keyframeAnimation.autoreverses = false
    keyframeAnimation.removedOnCompletion = false
    keyframeAnimation.fillMode = kCAFillModeForwards
    keyframeAnimation.duration = 0.6
    currentView.layer.addAnimation(keyframeAnimation, forKey: "exchangeScale")





}

func nomalScaleAnimation(currentView:UIView,obj : NSDictionary){

    let toScale = obj.objectForKey("toScale") as! CGFloat
    let fromScale = obj.objectForKey("fromScale") as! CGFloat
    let layerPosition = currentView.layer.position
    let keyframeAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
    keyframeAnimation.values = [fromScale,toScale]
     keyframeAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear),CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)]
    keyframeAnimation.keyTimes = [0,1.0]
    keyframeAnimation.autoreverses = false
    keyframeAnimation.removedOnCompletion = false
    keyframeAnimation.fillMode = kCAFillModeForwards
    keyframeAnimation.duration = 0.6
    currentView.layer.addAnimation(keyframeAnimation, forKey: "nomalScale")
}


func elasticScaleShowAnimation(currentView:UIView){

    

    let layerPosition = currentView.layer.position
    let keyframeAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
    //    keyframeAnimation.duration = 1.0
//    keyframeAnimation.delegate = self
    
    //设定关键帧位置，必须含起始与终止位置
    keyframeAnimation.values = [1.2,1,1.1,1]
    
    
    //        timeFunctions属性
    keyframeAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear),CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear),CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear),CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)]
        //        用过UIKit层动画的同学应该对这个属性不陌生，这个属性用以指定时间函数，类似于运动的加速度，有以下几种类型。上例子的AB段就是用了淡入淡出效果。记住，这是一个数组，你有几个子路径就应该传入几个元素
    
    //设定每个关键帧的时长，如果没有显式地设置，则默认每个帧的时间=总duration/(values.count - 1)
    keyframeAnimation.keyTimes = [0,0.4,0.7,1.0]
    keyframeAnimation.autoreverses = false
    keyframeAnimation.removedOnCompletion = false
    keyframeAnimation.fillMode = kCAFillModeForwards
    //        currentView.layer.position = CGPointMake(layerPosition.x, layerPosition.y)
    keyframeAnimation.duration = 0.6
    
    currentView.layer.addAnimation(keyframeAnimation, forKey: "showScale")


}

func elasticScaleDissmissAnimation(currentView:UIView){

    let layerPosition = currentView.layer.position
    let keyframeAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
    //    keyframeAnimation.duration = 1.0
//    keyframeAnimation.delegate = self
    
    //设定关键帧位置，必须含起始与终止位置
    keyframeAnimation.values = [1,0.9,0.8,0.7]
    
    
    //        timeFunctions属性
    keyframeAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear),CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear),CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear),CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)]
    
    //        用过UIKit层动画的同学应该对这个属性不陌生，这个属性用以指定时间函数，类似于运动的加速度，有以下几种类型。上例子的AB段就是用了淡入淡出效果。记住，这是一个数组，你有几个子路径就应该传入几个元素
    
    //设定每个关键帧的时长，如果没有显式地设置，则默认每个帧的时间=总duration/(values.count - 1)
    keyframeAnimation.keyTimes = [0,0.4,0.8,1]
    keyframeAnimation.autoreverses = false
    keyframeAnimation.removedOnCompletion = false
    keyframeAnimation.fillMode = kCAFillModeForwards
    //        currentView.layer.position = CGPointMake(layerPosition.x, layerPosition.y)
    keyframeAnimation.duration = 0.6
    
    currentView.layer.addAnimation(keyframeAnimation, forKey: "dismissScale")
    




}


