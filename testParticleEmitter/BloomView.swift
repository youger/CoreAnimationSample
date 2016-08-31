//
//  BloomView.swift
//  testParticleEmitter
//
//  Created by Jingyue on 8/30/16.
//  Copyright © 2016 Jingyue. All rights reserved.
//

import UIKit

enum CornerRect {
    
    case LeftTop
    case Top
    case RightTop
    case Left
    case LeftBottom
    case Bottom
    case RightBottom
    case Right
}

class BloomView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var emitterParticle : CALayer!
    var praise : CALayer!
    var duration = 1.0
//    var target : AnyObject ?
//    var action : Selector ?
    
    let corners = [CornerRect.LeftTop, CornerRect.Top, CornerRect.RightTop, CornerRect.Left, CornerRect.LeftBottom, CornerRect.Bottom, CornerRect.RightBottom, CornerRect.Right]
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        configureSublayers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        configureSublayers()
    }
    
    func configureSublayers() {
        
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.blackColor().CGColor
        
        emitterParticle = CALayer()
        emitterParticle.frame = bounds
        
        for corner in corners {
            
            createCornerParticle(corner)
        }
        createPraiseLayer()
        
        let tap = UITapGestureRecognizer.init(target: self, action:#selector(handleTapGesture))
        self.addGestureRecognizer(tap)
    }
    
    func createPraiseLayer() {
        
        praise = CALayer()
        praise.position = CGPointMake(bounds.size.width/2.0, bounds.size.height/2.0)
        praise.contents = UIImage(named: "ui_like")?.CGImage
        praise.contentsScale = 0.8
        praise.bounds = CGRectInset(bounds, 15, 15)
        praise.borderWidth = 0.5
        praise.borderColor = UIColor.redColor().CGColor
        
        layer.addSublayer(praise)
    }
    
    func createCornerParticle(corner : CornerRect ) {
        
        let emitterCell = CAEmitterCell()
        emitterCell.birthRate = 3
        emitterCell.lifetime = Float(duration)
        emitterCell.contentsScale = 10
        emitterCell.velocity = 5.0
        emitterCell.velocityRange = 10.0
        
        let emitterCellb = CAEmitterCell()
        emitterCellb.contents = UIImage.init(named: "Star")?.CGImage
        emitterCellb.birthRate = 3
        emitterCellb.lifetime = Float(duration)
        emitterCellb.contentsScale = 6
//        emitterCellb.velocity = 5.0
//        emitterCellb.velocityRange = 10.0
        
        emitterCell.emissionRange = CGFloat(M_PI_2)
        emitterCell.emissionRange = CGFloat(-M_PI_2)
        emitterCell.scaleRange = 2.0
        
        let width = bounds.width/3.0
        let height = bounds.height/3.0
        let rect = CGRectMake(0, 0, width, height)
        
        let emitter = CAEmitterLayer()
        emitter.frame = rect
        emitter.emitterSize = rect.size
        emitter.lifetime = 1.0
        emitter.emitterShape = kCAEmitterLayerPoint
        emitter.emitterMode = kCAEmitterLayerSurface
        emitter.emitterCells = [emitterCell,emitterCellb]
        emitter.emitterPosition = CGPointMake(rect.size.width/2.0, rect.size.height/2.0)
        
        configureParitcle(emitter, corner: corner)
        
        emitterParticle.addSublayer(emitter)
    }
    
    func configureParitcle(emitter : CAEmitterLayer, corner : CornerRect) {
        
        var rect = emitter.frame
        let emitterCell1 = emitter.emitterCells![0]
    
        switch corner {
        
        case .LeftTop:
            
            rect.origin = CGPointMake(0, 0)
            emitterCell1.contents = UIImage.init(named: "dot-1")?.CGImage
            emitterCell1.color = UIColor.greenColor().CGColor
            
            emitterCell1.xAcceleration = -20.0
            emitterCell1.yAcceleration = -10.0
            
            emitter.emitterPosition = CGPointMake(rect.size.width*2/3.0, rect.size.height*2/3.0)
           
            emitterCell1.color = UIColor.redColor().CGColor
            
        case .Top:
            
            rect.origin = CGPointMake(bounds.width/3.0, 0)
            emitterCell1.contents = UIImage.init(named: "dot-1-1")?.CGImage
            emitterCell1.color = UIColor.greenColor().CGColor
            
            emitterCell1.yAcceleration = -10.0
            
            emitterCell1.color = UIColor.greenColor().CGColor
            
        case .RightTop:
            
            rect.origin = CGPointMake(bounds.width * 2/3.0, 0)
            emitterCell1.contents = UIImage.init(named: "dot-2")?.CGImage
            
            emitterCell1.xAcceleration = 10.0
            emitterCell1.yAcceleration = -10.0
            emitter.emitterPosition = CGPointMake(rect.size.width/3.0, rect.size.height*2/3.0)
            
            emitterCell1.color = UIColor.blueColor().CGColor
            
        case .Left:
            
            rect.origin = CGPointMake(0, bounds.width/3.0)
            emitterCell1.contents = UIImage.init(named: "dot-2-1")?.CGImage
            
            emitterCell1.xAcceleration = -20.0
            
            emitterCell1.color = UIColor.cyanColor().CGColor
            
        case .LeftBottom:
            
            rect.origin = CGPointMake(0, bounds.width * 2/3.0)
            emitterCell1.contents = UIImage.init(named: "dot-3")?.CGImage
            
            emitterCell1.xAcceleration = -20.0
            emitterCell1.yAcceleration = 10.0
            emitter.emitterPosition = CGPointMake(rect.size.width*2/3.0, rect.size.height/3.0)
            
            emitterCell1.color = UIColor.yellowColor().CGColor
            
        case .Bottom:
            
            rect.origin = CGPointMake(bounds.width/3.0, bounds.width * 2/3.0)
            emitterCell1.contents = UIImage.init(named: "dot-3-1")?.CGImage
            
            emitterCell1.yAcceleration = 10.0
            
            emitterCell1.color = UIColor.magentaColor().CGColor
            
        case .RightBottom:
            
            rect.origin = CGPointMake(bounds.width*2/3.0, bounds.height*2/3.0)
            emitterCell1.contents = UIImage.init(named: "dot-4")?.CGImage
            
            emitterCell1.xAcceleration = 10.0
            emitterCell1.yAcceleration = 10.0
            
            emitter.emitterPosition = CGPointMake(rect.size.width/3.0, rect.size.height/3.0)
            
            emitterCell1.color = UIColor.orangeColor().CGColor
            
        case .Right:
            
            rect.origin = CGPointMake(bounds.width*2/3.0, bounds.height/3.0)
            emitterCell1.contents = UIImage.init(named: "dot-4-1")?.CGImage
            
            emitterCell1.xAcceleration = 10.0
            
            emitterCell1.color = UIColor.purpleColor().CGColor
        }
        //emitterCell.emissionLongitude = CGFloat(M_PI_2)
        emitter.frame = rect
    }
    
    func handleTapGesture() {
        
        startAnimate()
    }
    
    func startAnimate() {
        
        if userInteractionEnabled {
         
            userInteractionEnabled = false
            
            let spring = CASpringAnimation(keyPath: "transform");
            spring.fromValue = NSValue.init(CATransform3D:CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(0.2, 0.2)))
            //spring.toValue = NSValue.init(CATransform3D:CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(2, 2))) //view.bounds.height/2.0 - 100.0
            spring.damping = 8.0
            spring.initialVelocity = 10.0
            spring.stiffness = 200
            spring.duration = duration
            spring.delegate = self
            praise.addAnimation(spring, forKey: nil)
            
            spring.fromValue = NSValue.init(CATransform3D:CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(0.8, 0.8)))
            
            layer.addSublayer(emitterParticle)
        }
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        emitterParticle.removeFromSuperlayer()
        userInteractionEnabled = true
    }
}
