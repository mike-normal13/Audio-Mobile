//
//  PlaySound.swift
//  Perc_Whistle
//
//  Created by mike on 11/11/16.
//  Copyright © 2016 mike. All rights reserved.
//

import Foundation
import AudioKit

class PlaySound: AudioKit
{
    //      player nodes will be responsible for playing sound
    private var _akPlayerFullSound: AKAudioPlayer! = nil;
    private var _akPlayerNoEnd: AKAudioPlayer! = nil;
    private var _akPlayerEnd: AKAudioPlayer! = nil;
    
    private var _audioFileNSURLFullSound: NSURL! = nil;
    private var _audioFileNSURLNoEnd: NSURL! = nil;
    private var _audioFileNSURLEnd: NSURL! = nil;
    
    private var _akAudioFileFullSond: AKAudioFile! = nil;
    private var _akAudioFileNoEnd: AKAudioFile! = nil;
    private var _akAudioFileEnd: AKAudioFile! = nil;
    
    //var mic: AKMicrophone! = nil
    var tracker: AKFrequencyTracker! = nil
    var silence: AKBooster! = nil;
    
    //private var _mixer: AVAudioMixerNode! = nil;
    private var _akMixer: AKMixer! = nil;
    
    override init()
    {
        _akMixer = AKMixer();
        
        _audioFileNSURLFullSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "Sounds/whilstle_full_sound.wav", ofType: nil)!);
        _audioFileNSURLNoEnd = NSURL(fileURLWithPath: Bundle.main.path(forResource: "Sounds/whilstle_no_end.wav", ofType: nil)!);
        _audioFileNSURLEnd = NSURL(fileURLWithPath: Bundle.main.path(forResource: "Sounds/whilstle_end.wav", ofType: nil)!);
        
        // intialize akAudioFiles from URLS
        do
        {
            try _akAudioFileFullSond = AKAudioFile(forReading: _audioFileNSURLFullSound as URL);
            try _akAudioFileNoEnd = AKAudioFile(forReading: _audioFileNSURLNoEnd as URL);
            try _akAudioFileEnd = AKAudioFile(forReading: _audioFileNSURLEnd as URL);
        }
        catch
        {
            print("there was a problem opening an audio file from a URL");
        }
        
        // intialize AudioPlayers
        do
        {
            try _akPlayerFullSound = AKAudioPlayer(file: _akAudioFileFullSond);
            try _akPlayerNoEnd = AKAudioPlayer(file: _akAudioFileNoEnd);
            try _akPlayerEnd = AKAudioPlayer(file: _akAudioFileEnd);
            
        }
        catch
        {
            print("there was problem initializing an AKAudioPlayer");
        }
        
        //  TODO: ********* maybe set user defined default values for playernodes here.....
        
        _akMixer.connect(_akPlayerFullSound);
        _akMixer.connect(_akPlayerNoEnd);
        _akMixer.connect(_akPlayerEnd);
        
        AudioKit.output = _akMixer;         // suspect
        
        //try self._engine.start();         // not seeing a port for this
        AudioKit.start();
        print("Audio engine is running");
    }
    
    // TODO: have this method maybe take in something, maybe not
    func triggerSound()
    {
        if (_akPlayerFullSound.isPlaying)
        {
            //  TODO: incorperate looping!!!
            _akPlayerFullSound.stop();          // TODO: we will need tio reevaluate this logic.....
            _akPlayerFullSound.play();          // debug for now
        }
        else
        {
            _akPlayerFullSound.play();
        }
    }
    
    func unTriggerSound()
    {
        if(_akPlayerFullSound.isPlaying)
        {
            _akPlayerFullSound.stop()
            _akPlayerEnd.play();            // play the decay of the sound file upon  stopping playback
            //_akPlayerFullSound.stop();
        }
    }
    
    // see if AudioKit is running
    func isAudioKitRunning() -> Bool
    {
        return AudioKit.engine.isRunning
    }
    
    func restartAudioKit()
    {
        AudioKit.start();
    }
    
    func stopAudioKit()
    {
        AudioKit.stop();
    }
}
