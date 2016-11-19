//
//  PlayControl.swift
//  First_Perc
//
//  Created by mike on 9/19/16.
//  Copyright © 2016 mike. All rights reserved.
//

import UIKit
import CoreMotion

class PlayControl: UIControl
{
    private var _touchDownMajorRadius: CGFloat! = nil;
    private var _force: CGFloat! = nil;
    
    var touchDownMajorRadius: CGFloat  { get {return _touchDownMajorRadius} }
    
    var force: CGFloat!
    {
        get{return _force;}
    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame);
        self.frame = frame;
        
        backgroundColor = UIColor.orange;
        _touchDownMajorRadius = 0;
        self.isMultipleTouchEnabled = true;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  TODO: this is where we MUST nail down getting more accuracy with fore touch!!!!!!
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        _touchDownMajorRadius = touches.first?.majorRadius;
        //var touches = touches
        _force = touches.first?.force;
        self.sendActions(for: UIControlEvents.touchDown);
        //print("touches began major radius: " + (touches.first?.majorRadius.description)!)
        //print("touches began force: " + (touches.first?.force.description)!);  // TODO: don't forget about this!!!
        //print("touches begand maximum possible force: " + (touches.first?.maximumPossibleForce.description)!);
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        self.sendActions(for: UIControlEvents.touchUpInside);
        //self.sendAction(<#T##action: Selector##Selector#>, to: <#T##Any?#>, for: <#T##UIEvent?#>)
    }
}
