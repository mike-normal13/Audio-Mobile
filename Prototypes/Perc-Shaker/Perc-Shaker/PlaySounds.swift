//
//  PlaySounds.swift
//  Perc-Shaker
//
//  Created by mike on 11/12/16.
//  Copyright © 2016 mike. All rights reserved.
//

import Foundation
import AVFoundation

class PlaySounds
{
    // Setup engine and node instances
    private var _engine: AVAudioEngine;
    private var _format: AVAudioFormat! = nil;
    private var error: NSError?
    
    private var _playerNode00: AVAudioPlayerNode! = nil;
    
    private var _audioFileNSURL00: NSURL! = nil;
    private var _audioFileNSURL01: NSURL! = nil;
    
    private var _audioFileArray: [AVAudioFile]! = nil
    
    private var _mixer: AVAudioMixerNode! = nil;
    
    private var _playIndex: Int = 0;
    
    init()
    {
        _engine = AVAudioEngine();
        let input = _engine.inputNode;
        _mixer = _engine.mainMixerNode;
        
        _format = input!.inputFormat(forBus: 0);
        
        _audioFileArray = [AVAudioFile]();
        
        _playerNode00 = AVAudioPlayerNode();
        _playerNode00.volume = 50.0;             // suspect value
        
        _audioFileNSURL00 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "Sounds/Hi_Shk1.wav", ofType: nil)!);
        _audioFileNSURL01 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "Sounds/Hi_Shk2.wav", ofType: nil)!);
        
        do
        {
            try _audioFileArray.append(AVAudioFile(forReading: _audioFileNSURL00 as URL));
            try _audioFileArray.append(AVAudioFile(forReading: _audioFileNSURL01 as URL));
        }
        catch
        {
            print("there was a problem opening an audio file");
        }
        
        _engine.attach(_playerNode00);
        _engine.connect(_playerNode00, to: _mixer, format: _format);
        
        do
        {
            try self._engine.start();
            print("Audio engine is running");
        }
        catch
        {
            print("there was a problem starting the AVAudioEngine!");
        }
    }
    
    func triggerSound()
    {
        print("in triggerSound()");
        _playerNode00.scheduleFile(_audioFileArray[_playIndex], at: nil, completionHandler: nil);
        _playerNode00.play()
        
        _playIndex = _playIndex == 0 ? 1 : 0;
    }
}
