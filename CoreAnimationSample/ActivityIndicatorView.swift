//
//  ActivityIndicatorView.swift
//  testCA
//
//  Created by Jingyue on 9/5/16.
//  Copyright © 2016 Jingyue. All rights reserved.
//

import UIKit

class ActivityIndicatorView: UIView {

    
    private var arcLayerA: CAShapeLayer?
    private var arcLayerB: CAShapeLayer?
    private var _isAnimating : Bool = false
    
    var lineWidth : CGFloat = 2.0
    var speed : CGFloat = 2.0
    var isAnimating : Bool{
    
        return _isAnimating
    }
    
    var tintColorA : UIColor? = UIColor.redColor(){
        
        willSet{
            arcLayerA?.strokeColor = newValue?.CGColor
        }
    }
    var tintColorB : UIColor? = UIColor.lightGrayColor(){
        
        willSet(newTintColor){
            arcLayerB?.strokeColor = newTintColor?.CGColor
        }
    }
    
    var contentView: UIView?{
        
        willSet(content){
            
            guard content != nil else{ return }
            addSubview(content!)
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
    
    func createArcLayer() -> CAShapeLayer {
        
        let arcLayer = CAShapeLayer()
        arcLayer.fillColor = UIColor.clearColor().CGColor
        arcLayer.lineWidth = lineWidth
        arcLayer.path = UIBezierPath(ovalInRect: bounds).CGPath
        
        arcLayer.frame = bounds
        
        return arcLayer
    }
    
    func configureSublayers() {
        
        arcLayerA = createArcLayer()
        arcLayerA?.strokeColor = tintColorA?.CGColor
        arcLayerA?.strokeStart = 0.75
    
        arcLayerB = createArcLayer()
        arcLayerB?.strokeColor = tintColorB?.CGColor
        arcLayerB?.strokeStart = 0.25
        arcLayerB?.strokeEnd = 0.5
        
        layer.addSublayer(arcLayerB!)
        layer.addSublayer(arcLayerA!)
    }
    
    func startAnimate() {
        
        if _isAnimating { return }
        
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = 2 * M_PI
        animation.repeatCount = HUGE
        animation.duration = Double(speed)
        //animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        arcLayerA?.addAnimation(animation, forKey: nil)
        
        animation.toValue = -2*M_PI
        arcLayerB?.addAnimation(animation, forKey: nil)
        
        _isAnimating = true
    }
    
    func stopAnimate() {
        
        _isAnimating = false
        
        layer.removeAllAnimations()
        removeFromSuperview()
    }
}
