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
        
        let leftOrRight = (view.bounds.width - 50)/2.0
        let topOrBottom = (view.bounds.height - 50)/2.0
        let rect = UIEdgeInsetsInsetRect(view.bounds, UIEdgeInsetsMake(topOrBottom, leftOrRight, topOrBottom, leftOrRight))
        
        bloom = BloomView.init(frame: rect)
        //bloom?.duration = 5.0
        view.addSubview(bloom!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animateEmitterLayer(sender : AnyObject) {
        
        bloom?.startAnimate()
    }
}

