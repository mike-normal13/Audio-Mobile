//
//  PlayControl.swift
//  Perc_Whistle
//
//  Created by mike on 11/11/16.
//  Copyright © 2016 mike. All rights reserved.
//


//      TODO: pretty sure code involving the mic needs to go in PlaySound class
import UIKit
import AudioKit

class PlayControl
{
    private var _mic: AKMicrophone! = nil
    private var _tracker: AKFrequencyTracker! = nil
    private var _silence: AKBooster! = nil;
    
    var mic: AKMicrophone!
    {
        get{return _mic}
    }
    
    //override init(frame: CGRect)
    init()
    {
        //super.init(frame: frame);
        //super.init();
        //self.frame = frame;
        
        //backgroundColor = UIColor.orange;
        //self.isMultipleTouchEnabled = true;
        
        print("Nil?")
        //_mic = AKMicrophone();       // TODO:    this causes cryptic error
  
        
        
//        tracker = AKFrequencyTracker.init(mic);
//        silence = AKBooster(tracker, gain: 0);
//        
//        AudioKit.output = silence;
//        AudioKit.start();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func stopAudioKit()
    {
        AudioKit.stop();
    }
    
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
//    {
//        self.sendActions(for: UIControlEvents.touchDown);
//    }
//    
//    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
//        
//        self.sendActions(for: UIControlEvents.touchUpInside);
//    }
}

