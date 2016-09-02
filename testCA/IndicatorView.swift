//
//  IndicatorView.swift
//  testParticleEmitter
//
//  Created by Jingyue on 9/2/16.
//  Copyright © 2016 Jingyue. All rights reserved.
//

import Foundation
import UIKit

public typealias IndicatorClosure = () -> Void

class IndicatorView: UIView {
    
    var progressLayer : CAShapeLayer?
    var duration = 1.0
    var doneClosure : IndicatorClosure?
    
    var progress : Float {
    
        set(progress){
        
            progressLayer?.strokeEnd = CGFloat(progress)
//            if progress > 0.2 {
//                progressLayer?.strokeStart = CGFloat(Double(progress) - 0.2)
//            }
        }
        
        get{
            return self.progress
        }
    }
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        configureSublayers()
    }
    
    required init?(coder aDecoder: NSCoder) {
     
        super.init(coder: aDecoder)
        
        configureSublayers()
    }
    
    func configureSublayers() {
        
        progressLayer = CAShapeLayer()
        progressLayer?.frame = bounds
        progressLayer?.path = UIBezierPath(ovalInRect: bounds).CGPath
        progressLayer?.fillColor = UIColor.clearColor().CGColor
        progressLayer?.strokeColor = UIColor .redColor().CGColor
        progressLayer?.lineWidth = 2.0
        
//        progressLayer?.strokeStart = 0.4
        progressLayer?.strokeEnd = 0.0
        progressLayer?.setAffineTransform(CGAffineTransformMakeRotation(CGFloat(-M_PI_2)))
        
        layer.addSublayer(progressLayer!)
    }
    
    func startAnimate() -> IndicatorView {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1.0
        animation.duration = duration
        animation.delegate = self
        
        progressLayer?.addAnimation(animation, forKey: nil)
        
        return self
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        if (doneClosure != nil) {
            doneClosure!()
        }
    }
}