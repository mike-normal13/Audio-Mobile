//
//  PlayView.swift
//  First_Perc
//
//  Created by mike on 9/19/16.
//  Copyright © 2016 mike. All rights reserved.
//

import UIKit

class PlayView: UIView
{
    private var _playControl: PlayControl! = nil;
    private var _playSound: PlaySound! = nil;
    // randomly generated after each press
    //private var _playIndex: Int! = nil;
    
//    var playControl: PlayControl! {
//        
//        get {return _playControl}
//        set {_playControl = newValue}
//    }
    
    var playSound: PlaySound{
        get {return _playSound}
    }

    
    override init(frame: CGRect)
    {
        super.init(frame: frame);
        self.frame = frame;
        //_playIndex = 0;
        
        _playSound = PlaySound();
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews()
    {
        _playControl = PlayControl(frame: self.bounds);
        addTargets();
        addSubview(_playControl);
    }
    
    private func addTargets()
    {
        _playControl.addTarget(self, action: #selector(self.pressPlay), for: UIControlEvents.touchDown);
        _playControl.addTarget(self, action: #selector(self.releasePlay), for: UIControlEvents.touchUpInside);
    }
    
    func pressPlay()
    {
        // TODO: instead of adjusting the volume of the playernode,
        //          we need to adjust the start time of the playback of the playernode,
        ///         there is a scheduleSegment() methond that we used for the drum machine.....
        //_playSound.playerNode.volume = Float(_playControl.touchDownMajorRadius);          // suspended for now.......
        _playSound.triggerSound(force: _playControl.force, touchRadius: _playControl.touchDownMajorRadius);
    }
    
    func releasePlay()
    {
        //_playIndex = (Int)(arc4random() % 1);
        _playSound.unTriggerSound();
    }
}
