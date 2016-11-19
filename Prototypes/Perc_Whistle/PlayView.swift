//
//  PlayView.swift
//  Perc_Whistle
//
//  Created by mike on 11/11/16.
//  Copyright © 2016 mike. All rights reserved.
//

import UIKit
import AudioKit

class PlayView: UIView
{
    //private var _playControl: PlayControl! = nil;
    private var _playSound: PlaySound! = nil;
    
    private var _mic: AKMicrophone! = nil
    private var _tracker: AKFrequencyTracker! = nil
    private var _silence: AKBooster! = nil;
    
    private var _frequencyLabel: UILabel! = nil;
    
    var playSound: PlaySound{
        get {return _playSound}
    }
    
//    var playControl: PlayControl!{
//        get{return _playControl}
//    }
    
    override init(frame: CGRect)
    {
        super.init(frame: frame);
        self.frame = frame;
        
        backgroundColor = UIColor.blue;
        
        _frequencyLabel = UILabel(frame: frame)
        
        _frequencyLabel.textColor = UIColor.white;
        _frequencyLabel.textAlignment = NSTextAlignment.center;
        
        _mic = AKMicrophone();       // TODO:    this causes cryptic error
        
        _tracker = AKFrequencyTracker.init(_mic);
        _silence = AKBooster(_tracker, gain: 10);
        AudioKit.output = _silence;
        
        _playSound = PlaySound();
        
        AudioKit.start();
        _mic.start();
        
        
    }

    override func draw(_ rect: CGRect) {
        
        _frequencyLabel.frame.size.width = frame.size.width
        _frequencyLabel.frame.size.height = frame.size.height;
        
        _frequencyLabel.frame.origin.x = rect.origin.x
        _frequencyLabel.frame.origin.y = rect.origin.y
        
        _frequencyLabel.text = _tracker.amplitude.description;
        
        addSubview(_frequencyLabel);
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override func layoutSubviews()
//    {
//        //_playControl = PlayControl(frame: self.bounds);
//        //_playControl = PlayControl();
//        addTargets();
//        //_frequencyLabel.text = _tracker.frequency.description;
//        //addSubview(_playControl);
//        
//        
//        addSubview(_frequencyLabel)
//    }

    private func addTargets()
    {
        // TODO: .touchDown & .touchUpInside are no longer going to work, need microphone events
        //_playControl.addTarget(self, action: #selector(self.pressPlay), for: UIControlEvents.touchDown);
        //_playControl.addTarget(self, action: #selector(self.releasePlay), for: UIControlEvents.touchUpInside);
    }
    
    // TODO: rename to startedBlowing or something like that
    func pressPlay()
    {
        _playSound.triggerSound();
    }
    
    // TODO: rename to stoppedBlowing or something like that
    func releasePlay()
    {
        _playSound.unTriggerSound();
    }
}

