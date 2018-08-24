//
//  BloomView.swift
//  testParticleEmitter
//
//  Created by Jingyue on 8/30/16.
//  Copyright © 2016 Jingyue. All rights reserved.
//

import UIKit

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
    var duration = 0.8
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
        
        //layer.borderWidth = 0.5
        //layer.borderColor = UIColor.blackColor().CGColor
        
        emitterParticle = CALayer()
        emitterParticle.frame = bounds
        
        for corner in corners {
            
            createCornerParticle(corner: corner)
        }
        createPraiseLayer()
        
        let tap = UITapGestureRecognizer.init(target: self, action:#selector(handleTapGesture))
        self.addGestureRecognizer(tap)
    }
    
    func createPraiseLayer() {
        
        praise = CALayer()
        praise.position = CGPoint(x:bounds.size.width/2.0, y:bounds.size.height/2.0)
        praise.contents = UIImage(named: "ui_like")?.cgImage
        praise.contentsScale = 0.8
        praise.bounds = bounds.insetBy(dx:bounds.size.width/6.0 + 5, dy:bounds.size.height/6.0 + 5)
        
        layer.addSublayer(praise)
    }
    
    func createCornerParticle(corner : CornerRect ) {
        
        let emitterCell = CAEmitterCell()
        emitterCell.birthRate = 2
        emitterCell.lifetime = Float(duration)
        emitterCell.contentsScale = 10.0
        emitterCell.velocity = 5.0
        
        emitterCell.emissionLongitude = CGFloat(Double.pi / 2)
        emitterCell.emissionRange = CGFloat(Double.pi)
        //emitterCell.scaleRange = 2.0
        
        let emitterCellb = CAEmitterCell()
        emitterCellb.contents = UIImage.init(named: "Star")?.cgImage
        emitterCellb.birthRate = 1
        emitterCellb.lifetime = Float(duration)
        emitterCellb.contentsScale = 6
//        emitterCellb.velocity = 5.0
//        emitterCellb.velocityRange = 10.0
        
        let width = bounds.width/3.0
        let height = bounds.height/3.0
        let rect = CGRect(x:0, y:0,width: width, height: height)
        
        let emitter = CAEmitterLayer()
        emitter.frame = rect
        emitter.emitterSize = rect.size
        emitter.lifetime = Float(duration)
        emitter.emitterShape = kCAEmitterLayerPoint
        emitter.emitterMode = kCAEmitterLayerSurface
        emitter.emitterCells = [emitterCell,emitterCellb]
        emitter.emitterPosition = CGPoint(x:rect.size.width/2.0, y:rect.size.height/2.0)
        
        configureParitcle(emitter: emitter, corner: corner)
        
        emitterParticle.addSublayer(emitter)
    }
    
    func configureParitcle(emitter : CAEmitterLayer, corner : CornerRect) {
        
        var rect = emitter.frame
        let emitterCell = emitter.emitterCells![0]
    
        emitterCell.contents = UIImage.init(named: corner.configure.content)?.cgImage
        emitterCell.color = corner.configure.color
        emitterCell.xAcceleration = corner.configure.acceleration.xAcceleration
        emitterCell.yAcceleration = corner.configure.acceleration.yAcceleration
        
        rect.origin = CGPoint(x:bounds.width * corner.configure.position.originX, y:bounds.height * corner.configure.position.originY)
        emitter.emitterPosition = CGPoint(x:rect.size.width * corner.configure.position.emitX, y:rect.size.height * corner.configure.position.emitY)
        
        emitter.frame = rect
    }
    
    func startAnimate() {
        
        if isUserInteractionEnabled {
         
            isUserInteractionEnabled = false
            
            let spring = CASpringAnimation(keyPath: "transform");
            spring.fromValue = NSValue(caTransform3D:CATransform3DMakeAffineTransform(CGAffineTransform(scaleX: 0.2, y: 0.2)))
            //spring.toValue = NSValue.init(CATransform3D:CATransform3DMakeAffineTransform(CGAffineTransformMakeScale(2, 2))) //view.bounds.height/2.0 - 100.0
            spring.damping = 8.0
            spring.initialVelocity = 10.0
            spring.stiffness = 200
            spring.duration = duration
            spring.delegate = self
            praise.add(spring, forKey: nil)
            
            spring.fromValue = NSValue(caTransform3D:CATransform3DMakeAffineTransform(CGAffineTransform(scaleX: 0.8, y: 0.8)))
            
            layer.addSublayer(emitterParticle)
        }
    }
    
    @objc func handleTapGesture() {
        
        startAnimate()
    }
}

extension BloomView :CAAnimationDelegate{
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool){
        
        emitterParticle.removeFromSuperlayer()
        isUserInteractionEnabled = true
    }
}
