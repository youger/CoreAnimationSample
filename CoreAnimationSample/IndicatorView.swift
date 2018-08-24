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
    
    private var progressLayer : CAShapeLayer?
    var duration = 1.0
    var doneClosure : IndicatorClosure?
    
    var progress : Float = 0.0 {
    
        willSet{
        
            progressLayer?.strokeEnd = CGFloat(newValue)
//            if progress > 0.2 {
//                progressLayer?.strokeStart = CGFloat(Double(progress) - 0.2)
//            }
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
        progressLayer?.path = UIBezierPath(ovalIn: bounds).cgPath
        progressLayer?.fillColor = UIColor.clear.cgColor
        progressLayer?.strokeColor = UIColor .red.cgColor
        progressLayer?.lineWidth = 2.0
        
//        progressLayer?.strokeStart = 0.4
        progressLayer?.strokeEnd = 0.0
        progressLayer?.setAffineTransform(CGAffineTransform(rotationAngle: CGFloat(-Double.pi / 2)))
        
        layer.addSublayer(progressLayer!)
    }
    
    func startAnimate() -> IndicatorView {
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = duration
        animation.delegate = self as? CAAnimationDelegate
        
        progressLayer?.add(animation, forKey: nil)
        
        return self
    }
    
    func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        if (doneClosure != nil) {
            doneClosure!()
        }
    }
}
