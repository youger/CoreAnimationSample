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
        
        let loadingButton = createButton(title: "Loading", action: #selector(loadingAnimate))
        loadingButton.center = CGPoint(x: view.center.x / 2, y: view.bounds.height - 50)
        view.addSubview(loadingButton)
        
        let animateButton = createButton(title: "Bloom", action: #selector(bloomAnimate))
        animateButton.center = CGPoint(x: view.center.x * 3 / 2, y: view.bounds.height - 50)
        view.addSubview(animateButton)
        
        let slider = UISlider(frame: CGRect(x: (view.bounds.width - 200) / 2.0, y: animateButton.frame.origin.y - 50, width: 200, height: 44))
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        view.addSubview(slider)
        
        let leftOrRight = (view.bounds.width - 50)/2.0
        let topOrBottom = (view.bounds.height - 50)/2.0
        var rect = UIEdgeInsetsInsetRect(view.bounds, UIEdgeInsetsMake(topOrBottom, leftOrRight, topOrBottom, leftOrRight))
        
        bloom = BloomView.init(frame: rect)
        //bloom?.duration = 5.0
        
        indicator = IndicatorView.init(frame: rect)
        indicator?.isUserInteractionEnabled = false
        
        rect.origin.y = rect.origin.y - 80
        activityIndicator = ActivityIndicatorView.init(frame: rect)
        activityIndicator?.tintColorA = UIColor.init(red: 255/255.0, green: 102/255.0, blue: 153/255.0, alpha: 1.0)
        activityIndicator?.tintColorB = UIColor.init(red: 240/255.0, green: 233/255.0, blue: 235/255.0, alpha: 1.0)
        activityIndicator?.speed = 1.0
        
        label = UILabel(frame: (activityIndicator?.bounds)!)
        label!.textColor = UIColor.init(red: 255/255.0, green: 102/255.0, blue: 153/255.0, alpha: 1.0)
        label!.textAlignment = .center
        label!.text = String(timeCount)
        activityIndicator?.contentView = label
        
        
        view.addSubview(bloom!)
        view.addSubview(indicator!)
        view.addSubview(activityIndicator!)
        
        loadingAnimate(sender: self)
    }
    
    func createButton(title: String, action: Selector) -> UIButton {
        
        let button = UIButton.init(type: .system)
        button.layer.borderColor = UIColor.blue.cgColor
        button.layer.borderWidth = 0.5
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)

        button.frame = CGRect(origin: CGPoint.zero, size: CGSize.init(width: 100.0, height: 44.0))
        
        return button
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func ticktack(timer : Timer) {
        
        guard timeCount > 0 else{
            
            //timer.invalidate()
            //activityIndicator?.stopAnimate()
            timeCount = 10

            bloomAnimate(sender: timer)
            
            return
        }
        timeCount = timeCount - 1
    }
    
    @objc func sliderValueChanged(sender : UISlider) {
        
        indicator?.progress = sender.value
        if sender.value == 1.0 {
            bloom?.startAnimate()
        }
    }
    
    @objc func loadingAnimate(sender : AnyObject) {
        
        if activityIndicator?.superview == nil{
            
            view.addSubview(activityIndicator!)
        }
        
        activityIndicator?.startAnimate()
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ticktack), userInfo: nil, repeats: true)
        
        return
    }
    
    @objc func bloomAnimate(sender : AnyObject) {
        
        indicator?.startAnimate().doneClosure = {
            
            self.bloom?.startAnimate()
        }
    }
}

