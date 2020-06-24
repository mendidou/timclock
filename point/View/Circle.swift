//
//  Circle.swift
//  point
//
//  Created by mendy aouizerat  on 23/06/2020.
//  Copyright © 2020 mendy aouizerat . All rights reserved.
//

import UIKit
class Circle {
    let CircleLayer = CAShapeLayer()
    var progressTimer:Timer?
    var circularPath: UIBezierPath
    
    //this  initializing and drawing circle
    init( drawCircleWith circularPathCenter : CGPoint , color : CGColor, stroke :CGFloat? = nil
        , fillcolor :CGColor? = nil, at position: CGPoint)
    {
        circularPath = UIBezierPath(arcCenter: circularPathCenter, radius: 100, startAngle: -CGFloat.pi/2 , endAngle:  1.5 * CGFloat.pi, clockwise: true)
        CircleLayer.path = circularPath.cgPath
        CircleLayer.strokeColor = color
        CircleLayer.lineCap = .round
        CircleLayer.fillColor = .none
        CircleLayer.lineWidth = 10
        if let fillcolor = fillcolor {CircleLayer.fillColor = fillcolor}
        if let stroke = stroke {CircleLayer.strokeEnd = stroke}
        
    }
    
    //this is making pulsing a circle
    func animatePulsatingCircle (position center : CGPoint) -> Circle{
        CircleLayer.position = center
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.3
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        CircleLayer.add(animation, forKey: "pulsing")
        return self
    }
    
    
    // this function is animating the progress circle for Swift and return Circle
       func animateProgressCircle(animation : CFTimeInterval = .oneMinute) -> Circle{
          let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
           basicAnimation.toValue = 1
           basicAnimation.duration = animation
           basicAnimation.fillMode = CAMediaTimingFillMode.forwards
           basicAnimation.isRemovedOnCompletion = false
           CircleLayer.add(basicAnimation, forKey: "circleAnimated")
           return self
       }
    
    // this function is animating the progress circle for objective-C
    @objc func C_animateProgressCircle(){
       animateProgressCircle()
    }
    
    //func that run every time
    func animateProgressWithTimer(every : TimeInterval){
        progressTimer = Timer.scheduledTimer(timeInterval: .oneMinute  , target: self,
                                             selector: #selector (C_animateProgressCircle), userInfo: nil, repeats: true)
    }
    
    //add a circle to a view
    func addCircle ( to View : UIView) -> Circle{
        View.layer.addSublayer(CircleLayer)
        return self
    }
    
   
}
