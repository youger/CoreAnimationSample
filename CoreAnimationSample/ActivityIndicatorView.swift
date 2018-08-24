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
    
    var tintColorA : UIColor? = UIColor.red{
        
        willSet{
            arcLayerA?.strokeColor = newValue?.cgColor
        }
    }
    var tintColorB : UIColor? = UIColor.lightGray{
        
        willSet(newTintColor){
            arcLayerB?.strokeColor = newTintColor?.cgColor
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
        arcLayer.fillColor = UIColor.clear.cgColor
        arcLayer.lineWidth = lineWidth
        arcLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        
        arcLayer.frame = bounds
        
        return arcLayer
    }
    
    func configureSublayers() {
        
        arcLayerA = createArcLayer()
        arcLayerA?.strokeColor = tintColorA?.cgColor
        arcLayerA?.strokeStart = 0.75
    
        arcLayerB = createArcLayer()
        arcLayerB?.strokeColor = tintColorB?.cgColor
        arcLayerB?.strokeStart = 0.25
        arcLayerB?.strokeEnd = 0.5
        
        layer.addSublayer(arcLayerB!)
        layer.addSublayer(arcLayerA!)
    }
    
    func startAnimate() {
        
        if _isAnimating { return }
        
        let animation = CABasicAnimation(keyPath: "transform.rotation")
        animation.toValue = 2 * Double.pi
        animation.repeatCount = HUGE
        animation.duration = Double(speed)
        //animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        
        arcLayerA?.add(animation, forKey: nil)
        
        animation.toValue = -2*Double.pi
        arcLayerB?.add(animation, forKey: nil)
        
        _isAnimating = true
    }
    
    func stopAnimate() {
        
        _isAnimating = false
        
        layer.removeAllAnimations()
        removeFromSuperview()
    }
}
