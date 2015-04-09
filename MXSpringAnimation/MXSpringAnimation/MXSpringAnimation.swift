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
    case Content      // require a instead of  image Or layer
    case Shape
    case Alpha
    
}
private  let sharedInstance = MXSpringAnimation()

class MXSpringAnimation : NSObject {
    
    
    
    
    class var sharedMXSpringAnimation : MXSpringAnimation {
        
        return sharedInstance
        
    }
    
    
    
    
    //看印象笔记
    typealias mxAnimaionStop=()->Void
    typealias mxAnimationCompletion=(finished:Bool)->Void
    
    //func
    //var MXShowAnimationDidStop: (() -> Void)?
    
    var  stopFunc = mxAnimaionStop?()
    
    var  completion = mxAnimationCompletion?()
    
    
    
    
    func MXShowAnimation(currentView:UIView,type:AnimationType,obj: NSDictionary,completion:(finished:Bool)->Void){
        
        
        self.completion = completion
        
        
        switch type {
        case .ElasticScale :
            elasticScaleDissmissAnimation(currentView)
        case .NormalScale:
            nomalScaleAnimation(currentView,obj: obj)
        case .NormalY:
            nomalYAnimation(currentView, obj: obj)
        case .Content:
            contentAnimation(currentView,obj: obj)
        case .Alpha:
            alphaAnimation(currentView, obj: obj)
        default:
            break
            
            
            
            
            
        }
        
        
        
        
        
        
    }
    
    private  func alphaAnimation(currentView:UIView,obj : NSDictionary){
        
        
        let currentState                    =      obj.objectForKey("currentAlpha") as CGFloat
        let finalState                      =      obj.objectForKey("finalAlpha") as CGFloat
        let duration                        =      obj.objectForKey("duration")  as CFTimeInterval
        
        let alphaAnimation                  =      CABasicAnimation(keyPath: "opacity")
        alphaAnimation
        //alphaAnimation.
        
        alphaAnimation.fromValue            =      currentState
        alphaAnimation.toValue              =      finalState
        
        alphaAnimation.duration             =      duration
        
        alphaAnimation.autoreverses         =      false
        alphaAnimation.removedOnCompletion  =      false
        alphaAnimation.fillMode             = kCAFillModeForwards
        
        
        
        connectionBlock(alphaAnimation)
        
        currentView.layer.addAnimation(alphaAnimation, forKey: "alpha")
        
        
        
        
    }
    
    
    
    
    private  func contentAnimation(currentView:UIView,obj : NSDictionary){
        
        let changeImage = obj.objectForKey("newImage") as? UIImage
        
        
        let changeX = obj.objectForKey("x") as? CGFloat
        let changeY = obj.objectForKey("y") as? CGFloat
        let changeWidth = obj.objectForKey("width") as? CGFloat
        let changeHeight = obj.objectForKey("height") as? CGFloat
        
        let contentsAnimation = CABasicAnimation(keyPath: "contents")
        contentsAnimation.fromValue = currentView.layer.contents
        contentsAnimation.toValue = changeImage?.CGImage
        contentsAnimation.duration = 2.0
        //        imageLayer.contents = image2?.CGImage
        contentsAnimation.autoreverses = false
        contentsAnimation.removedOnCompletion = false
        contentsAnimation.fillMode = kCAFillModeForwards
        
        
        //        let boundsAnimation = CABasicAnimation(ke
        let boundsAnimation =  CABasicAnimation(keyPath: "bounds")
        //        boundsAnimation.fromValue = nsva
        boundsAnimation.fromValue = NSValue(CGRect: currentView.layer.bounds)
        boundsAnimation.toValue = NSValue(CGRect: CGRectMake(changeX!, changeY!, changeWidth!, changeHeight!))
        boundsAnimation.duration = 2.0
        boundsAnimation.autoreverses = false
        boundsAnimation.removedOnCompletion = false
        boundsAnimation.fillMode = kCAFillModeForwards
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [contentsAnimation,boundsAnimation]
        
        groupAnimation.autoreverses = false
        groupAnimation.removedOnCompletion = false
        groupAnimation.fillMode = kCAFillModeForwards
        groupAnimation.duration = 2.0
        
        
        connectionBlock(groupAnimation)
        currentView.layer.addAnimation(groupAnimation, forKey: "ContentAndBounds")
        
        
        
        
        
    }
    
    private  func MXDismissAnimation(currentView:UIView,type:AnimationType){
        
        
        switch type {
        case .ElasticScale :
            elasticScaleDissmissAnimation(currentView)
        default:
            break
            
            
            
            
        }
        
        
        
        
    }
    
    private  func nomalYAnimation(currentView:UIView,obj : NSDictionary){
        
        let layerPosition = currentView.layer.position
        
        print(layerPosition.y)
        
        
        
        let keyframeAnimation = CAKeyframeAnimation(keyPath: "transform.translation.y")
        let toValue = obj.objectForKey("toValue") as CGFloat
        
        let fromValue = obj.objectForKey("fromValue") as CGFloat
        keyframeAnimation.values = [fromValue,toValue]
        keyframeAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear),CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)]
        keyframeAnimation.keyTimes = [0,1.0]
        keyframeAnimation.autoreverses = false
        keyframeAnimation.removedOnCompletion = false
        keyframeAnimation.fillMode = kCAFillModeForwards
        keyframeAnimation.duration = 0.6
        connectionBlock(keyframeAnimation)
        currentView.layer.addAnimation(keyframeAnimation, forKey: "exchangeScale")
        
        
        
        
        
    }
    
    private  func nomalScaleAnimation(currentView:UIView,obj : NSDictionary){
        
        let toScale = obj.objectForKey("toScale") as CGFloat
        let fromScale = obj.objectForKey("fromScale") as CGFloat
        let layerPosition = currentView.layer.position
        let keyframeAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        keyframeAnimation.values = [fromScale,toScale]
        keyframeAnimation.timingFunctions = [CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear),CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)]
        keyframeAnimation.keyTimes = [0,1.0]
        keyframeAnimation.autoreverses = false
        keyframeAnimation.removedOnCompletion = false
        keyframeAnimation.fillMode = kCAFillModeForwards
        keyframeAnimation.duration = 0.6
        connectionBlock(keyframeAnimation)
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
        connectionBlock(keyframeAnimation)
        currentView.layer.addAnimation(keyframeAnimation, forKey: "showScale")
        
        
    }
    
    private  func elasticScaleDissmissAnimation(currentView:UIView){
        
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
        connectionBlock(keyframeAnimation)
        currentView.layer.addAnimation(keyframeAnimation, forKey: "dismissScale")
        
        
        
        
        
    }
    
    private  func shapeChange(){
        
        
        
        
        
        
        
        
        
        
    }
    
    private func connectionBlock(mainAnimation:CAAnimation){
        
        mainAnimation.didStar = { animation in
            
            
            
        }
        
        mainAnimation.didStop = {animation,boolean  in
            
            print(boolean)
            
            
            
            self.completion!(finished: boolean)
            
            if boolean {
                
                
            }
            
        }
        
        
        
        
    }
    
    
    
    
    
}
