//
//  PlaySound.swift
//  First_Perc
//
//  Created by mike on 9/19/16.
//  Copyright © 2016 mike. All rights reserved.
//

import Foundation
import AVFoundation

class PlaySound
{
    // Setup engine and node instances
    private var _engine: AVAudioEngine
    private var _format: AVAudioFormat! = nil //= input.inputFormatForBus(0)
    private var error: NSError?
    
    // array will hold seperate playback nodes
    private var _playerNodeArray: [AVAudioPlayerNode]! = nil;
    
    private var _audioFileNSURL00: NSURL! = nil;
    private var _audioFile00: AVAudioFile! = nil;
    
    private var _mixer: AVAudioMixerNode! = nil;
    
    private var _time1_D: Double! = nil; // 2nd hardest velocity
    private var _time2_D: Double! = nil; // 3rd hardest velocity
    private var _time3_D: Double! = nil; // 4th hardest velocity
    
    // instead of just playing one loaded sound at diferent volumes dependent upon touch force,
    //  softer touches will cause playback of the file to start later in the file,
    //      thereby eleminating the file's attack.
    private var _time1_AF: AVAudioFramePosition;
    private var _time2_AF: AVAudioFramePosition;
    private var _time3_AF: AVAudioFramePosition;
    
    private var _time1FrameCount: AVAudioFrameCount;
    private var _time2FrameCount: AVAudioFrameCount;
    private var _time3FrameCount: AVAudioFrameCount;
    
    private var _numberOfFrames: AVAudioFramePosition! = nil
    private var _numberOfFramesCount: AVAudioFrameCount! = nil;
    
    //
    private var _voicePolyphony = 4;
    private var _defaultPlayerVolume: Float = 90.0;
    
    // the number of AVAudioPlayers which are currently playing
    // this variable along with the playernode array are with the intent of preventing 
    //      rapid strikes from cuting of the playback of the previous strike
    private var _playersPlaying = 0;
    
    private var _opQueue: OperationQueue! = nil //  TODO: currently this may or may not actually making things better
    
    // this is here to cope with what happens when the audio routing changes due to blue tooth activation,
    //  or if the headphone jack is plugged in or unplugged while the app is running.
    var engine: AVAudioEngine
    {
        get {return _engine}
    }
    
    init()
    {
        _engine = AVAudioEngine();
        let input = _engine.inputNode;
        _mixer = _engine.mainMixerNode;
        
        _format = input!.inputFormat(forBus: 0);
        
        _audioFileNSURL00 = NSURL(fileURLWithPath: Bundle.main.path(forResource: "50_Kit _-_Perc_09.wav", ofType: nil)!);
        
        do
        {
            try _audioFile00 = AVAudioFile(forReading: _audioFileNSURL00 as URL);
        }
        catch
        {
            print("there was a problem opening an audio file");
        }
        
        _numberOfFrames =  _audioFile00.length;
        _numberOfFramesCount = AVAudioFrameCount(_numberOfFrames.toIntMax());
        
        _time1_D = Double(_numberOfFrames.toIntMax()) * 0.8333;
        _time2_D = Double(_numberOfFrames.toIntMax()) * 0.6666;
        _time3_D = Double(_numberOfFrames.toIntMax()) * 0.50;
        
        _time1FrameCount = AVAudioFrameCount(_time1_D);
        _time2FrameCount = AVAudioFrameCount(_time2_D);
        _time3FrameCount = AVAudioFrameCount(_time3_D);
        
//        print("_time1FrameCount: " + _time1FrameCount.description)
//        print("_time2FrameCount: " + _time2FrameCount.description)
//        print("_time3FrameCount: " + _time3FrameCount.description)
        
        _time1_AF = _numberOfFrames - AVAudioFramePosition(_time1_D);
        _time2_AF = _numberOfFrames - AVAudioFramePosition(_time2_D);
        _time3_AF = _numberOfFrames - AVAudioFramePosition(_time3_D);
        
        _opQueue = OperationQueue();
        
        initAudioPlayerArray();
        
        configureEngine();
        
        do
        {
            try self._engine.start();
            print("Audio engine is running");
        }
        catch
        {
            print("there was a problem starting the AVAudioEngine!");
        }
        
        print("Nil??")
    }
    
    func triggerSound(force: CGFloat, touchRadius: CGFloat)
    {
        triggerSegment(force: force, touchRadius: touchRadius);
        
    }
    
    func unTriggerSound()
    {
//        if(_playerNodeArray[_playersPlaying].isPlaying)
//        {
//            _playerNodeArray[_playersPlaying].stop();
//            
//            if(_playersPlaying < 0)
//            {
//                _playersPlaying -= 1;
//            }
//        }
    }
    
    func triggerSegment(force: CGFloat, touchRadius: CGFloat)
    {
        //_playersPlaying += 1;
        //  TODO: this does not seem to even remotely have the desired effect
        //_opQueue.addOperation()
            //{
                
                //print("Players playing: " + _playersPlaying.description)
                //print("force: " + force.description)
                if(force > 0.8 || touchRadius > 100) // highest velocity, start at beginning of file
                {
//                    if(_playerNodeArray[_playersPlaying].isPlaying)
//                    {
//                        _playerNodeArray[_playersPlaying].stop()
//                    }
                    self._playerNodeArray[self._playersPlaying].scheduleFile(self._audioFile00, at: nil, completionHandler: {self.playerCompletionHandler() });
                    self._playerNodeArray[self._playersPlaying].play();
                    //print("Played highest velocity")
                    //self._playersPlaying += 1;
                }
                else if((force <= 0.8 && force > 0.65) || touchRadius > 90)// second highest velocity
                {
//                    if(_playerNodeArray[_playersPlaying].isPlaying)
//                    {
//                        _playerNodeArray[_playersPlaying].stop()
//                    }
                    self._playerNodeArray[self._playersPlaying].scheduleSegment(self._audioFile00, startingFrame: self._time1_AF, frameCount: self._time1FrameCount, at: nil, completionHandler: { self.playerCompletionHandler()})
                    self._playerNodeArray[self._playersPlaying].play();
                    //print("Played second highest velocity")
                    //self._playersPlaying += 1;
                }
                else if((force <= 0.65 && force > 0.45) || touchRadius > 80)  // third highest velocity
                {
//                    if(_playerNodeArray[_playersPlaying].isPlaying)
//                    {
//                        _playerNodeArray[_playersPlaying].stop()
//                    }
                    self._playerNodeArray[self._playersPlaying].scheduleSegment(self._audioFile00, startingFrame: self._time2_AF, frameCount: self._time2FrameCount, at: nil, completionHandler: { self.playerCompletionHandler()})
                    self._playerNodeArray[self._playersPlaying].play();
                    //print("Played third highest velocity")
                    //self._playersPlaying += 1;
                }
                else    // lowest velocity
                {
//                    if(_playerNodeArray[_playersPlaying].isPlaying)
//                    {
//                        _playerNodeArray[_playersPlaying].stop()
//                    }
                    self._playerNodeArray[self._playersPlaying].scheduleSegment(self._audioFile00, startingFrame: self._time3_AF, frameCount: self._time3FrameCount, at: nil, completionHandler: { self.playerCompletionHandler()})
                    self._playerNodeArray[self._playersPlaying].play();
                    //print("Played fourth highest velocity")
                    //self._playersPlaying += 1;
                }
                print("_playersPlaying: " + self._playersPlaying.description)
        //}
        
        
        self._playersPlaying += 1;
    }
    
    private func initAudioPlayerArray()
    {
        _playerNodeArray = [AVAudioPlayerNode]();
        // 5 voice polyphony
        for i in 0..<_voicePolyphony{
            _playerNodeArray.append(AVAudioPlayerNode())
            _playerNodeArray[i].volume = _defaultPlayerVolume;
            //print("i: " + i.description);
        }
    }
    
    private func configureEngine()
    {
        for i in 0..<_voicePolyphony{
            _engine.attach(_playerNodeArray[i])
            _engine.connect(_playerNodeArray[i], to: _mixer, format: _format)
        }
    }
    
    private func playerCompletionHandler()
    {
        if(_playersPlaying > 0)
        {
            //Thread.sleep(forTimeInterval: TimeInterval(0.05))

            _playersPlaying -= 1;
        }
        print("complete")
    }
}
