//
//  ViewController.swift
//  testParticleEmitter
//
//  Created by Jingyue on 8/26/16.
//  Copyright © 2016 Jingyue. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var bloom : BloomView?
    var indicator : IndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let animateButton = UIButton.init(type: .System)
        animateButton.layer.borderColor = UIColor.blueColor().CGColor
        animateButton.layer.borderWidth = 0.5
        animateButton.setTitle("Spring", forState: .Normal)
        animateButton.addTarget(self, action: #selector(animateEmitterLayer), forControlEvents: .TouchUpInside)
        animateButton.frame = CGRect(x: (view.bounds.width - 100) / 2.0, y: view.bounds.height - 100, width: 100, height: 44)
        view.addSubview(animateButton)
        
        let slider = UISlider(frame: CGRect(x: (view.bounds.width - 200) / 2.0, y: animateButton.frame.origin.y - 50, width: 200, height: 44))
        slider.addTarget(self, action: #selector(sliderValueChanged), forControlEvents: .ValueChanged)
        view.addSubview(slider)
        
        let leftOrRight = (view.bounds.width - 50)/2.0
        let topOrBottom = (view.bounds.height - 50)/2.0
        let rect = UIEdgeInsetsInsetRect(view.bounds, UIEdgeInsetsMake(topOrBottom, leftOrRight, topOrBottom, leftOrRight))
        
        bloom = BloomView.init(frame: rect)
        //bloom?.duration = 5.0
        
        indicator = IndicatorView.init(frame: rect)
        indicator?.userInteractionEnabled = false
        
        view.addSubview(bloom!)
        view.addSubview(indicator!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sliderValueChanged(sender : UISlider) {
        
        indicator?.progress = sender.value
        if sender.value == 1.0 {
            bloom?.startAnimate()
        }
    }
    
    func animateEmitterLayer(sender : AnyObject) {
        
        indicator?.startAnimate().doneClosure = {
            
            self.bloom?.startAnimate()
        }
    }
}

