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
    var activityIndicator : ActivityIndicatorView?
    
    var label : UILabel?
    
    var timeCount : Int = 10{
        
        willSet{
            label!.text = String(newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let loadingButton = createButton("Loading", action: #selector(loadingAnimate))
        loadingButton.center = CGPointMake(view.center.x / 2, view.bounds.height - 50)
        view.addSubview(loadingButton)
        
        let animateButton = createButton("Bloom", action: #selector(bloomAnimate))
        animateButton.center = CGPointMake(view.center.x * 3 / 2, view.bounds.height - 50)
        view.addSubview(animateButton)
        
        let slider = UISlider(frame: CGRect(x: (view.bounds.width - 200) / 2.0, y: animateButton.frame.origin.y - 50, width: 200, height: 44))
        slider.addTarget(self, action: #selector(sliderValueChanged), forControlEvents: .ValueChanged)
        view.addSubview(slider)
        
        let leftOrRight = (view.bounds.width - 50)/2.0
        let topOrBottom = (view.bounds.height - 50)/2.0
        var rect = UIEdgeInsetsInsetRect(view.bounds, UIEdgeInsetsMake(topOrBottom, leftOrRight, topOrBottom, leftOrRight))
        
        bloom = BloomView.init(frame: rect)
        //bloom?.duration = 5.0
        
        indicator = IndicatorView.init(frame: rect)
        indicator?.userInteractionEnabled = false
        
        rect.origin.y = rect.origin.y - 80
        activityIndicator = ActivityIndicatorView.init(frame: rect)
        activityIndicator?.tintColorA = UIColor(colorLiteralRed: 255/255.0, green: 102/255.0, blue: 153/255.0, alpha: 1.0)
        activityIndicator?.tintColorB = UIColor(colorLiteralRed: 240/255.0, green: 233/255.0, blue: 235/255.0, alpha: 1.0)
        activityIndicator?.speed = 1.0
        
        label = UILabel(frame: (activityIndicator?.bounds)!)
        label!.textColor = UIColor(colorLiteralRed: 255/255.0, green: 102/255.0, blue: 153/255.0, alpha: 1.0)
        label!.textAlignment = .Center
        label!.text = String(timeCount)
        activityIndicator?.contentView = label
        
        
        view.addSubview(bloom!)
        view.addSubview(indicator!)
        view.addSubview(activityIndicator!)
        
        loadingAnimate(self)
    }
    
    func createButton(title: String, action: Selector) -> UIButton {
        
        let button = UIButton.init(type: .System)
        button.layer.borderColor = UIColor.blueColor().CGColor
        button.layer.borderWidth = 0.5
        button.setTitle(title, forState: .Normal)
        button.addTarget(self, action: action, forControlEvents: .TouchUpInside)

        button.frame = CGRectMake(0, 0, 100.0, 44.0)
        
        return button
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ticktack(timer : NSTimer) {
        
        guard timeCount > 0 else{
            
            //timer.invalidate()
            //activityIndicator?.stopAnimate()
            timeCount = 10

            bloomAnimate(timer)
            
            return
        }
        timeCount = timeCount - 1
    }
    
    func sliderValueChanged(sender : UISlider) {
        
        indicator?.progress = sender.value
        if sender.value == 1.0 {
            bloom?.startAnimate()
        }
    }
    
    func loadingAnimate(sender : AnyObject) {
        
        if activityIndicator?.superview == nil{
            
            view.addSubview(activityIndicator!)
        }
        
        activityIndicator?.startAnimate()
        NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(ticktack), userInfo: nil, repeats: true)
        
        return
    }
    
    func bloomAnimate(sender : AnyObject) {
        
        indicator?.startAnimate().doneClosure = {
            
            self.bloom?.startAnimate()
        }
    }
}

