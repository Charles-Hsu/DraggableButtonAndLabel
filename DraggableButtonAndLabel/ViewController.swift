//
//  ViewController.swift
//  DraggableButtonAndLabel
//
//  Created by Charles Hsu on 12/8/15.
//  Copyright © 2015 Pro Andy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let bounds = UIScreen.mainScreen().bounds
        let container = UIView(frame: CGRectMake(50, 50, bounds.size.width - 50 * 2, bounds.size.height - 50 * 2))
        container.backgroundColor = UIColor.grayColor()
        container.clipsToBounds = true
        
        self.view.addSubview(container)

        // create a new button
        let button = UIButton(type: UIButtonType.RoundedRect)
        button.setTitle("Button", forState: UIControlState.Normal)
        button.backgroundColor = UIColor.redColor()
        
        // add drag listener
        button.addTarget(self, action: "wasDragged:withEvent:", forControlEvents: UIControlEvents.TouchDragInside)
        
        // center and size
        button.frame = CGRectMake((self.view.bounds.size.width - 100)/2.0, (self.view.bounds.size.height - 50)/2.0, 100, 50)
        
        // add it, centered
        container.addSubview(button)
        
        // create t label
        let label = UILabel(frame: CGRectMake(10,10,100,50))
        label.text = "Label"
        label.textAlignment = NSTextAlignment.Center
        label.backgroundColor = UIColor.greenColor()
        
        // enable touch delievery
        label.userInteractionEnabled = true
        
        let gesture = UIPanGestureRecognizer(target: self, action: "labelDragged:")
        label.addGestureRecognizer(gesture)
        
        // add it
        container.addSubview(label)
        
    }

    func labelDragged(gesture: UIPanGestureRecognizer)
    {
        let label = gesture.view as! UILabel
        let translation = gesture.translationInView(label)
        
        // move label
        label.center = CGPointMake(label.center.x + translation.x, label.center.y + translation.y)
        
        // reset translateion
        gesture.setTranslation(CGPoint.zero, inView: label)
    }
    
    func wasDragged(button: UIButton, withEvent event: UIEvent)
    {
        print("button.superview?.frame = \(button.superview?.frame)")
        
        // get the touch
        let touch = event.touchesForView(button)?.first
        
        // get delta
        let previousLocation = touch?.previousLocationInView(button)
        let location = touch?.locationInView(button)
        let delta_x = location!.x - (previousLocation?.x)!
        let delta_y = location!.y - (previousLocation?.y)!
        
        print(location)
        
        // move button
        button.center = CGPointMake(button.center.x + delta_x, button.center.y + delta_y)
        
        print(button.center)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let touch = touches.first
        print(touch?.locationInView(self.view))
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

