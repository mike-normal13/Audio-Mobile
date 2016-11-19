//
//  ViewController.swift
//  First_Perc
//
//  Created by mike on 9/19/16.
//  Copyright © 2016 mike. All rights reserved.
//

import UIKit
import AVFoundation
import CoreMotion
import CoreMIDI

class ViewController: UIViewController {

    private var _playView: PlayView! = nil;
    
    private var _motionManager: CMMotionManager! = nil;
    private var _accelThreshold = 0.05;
    
    var playView: PlayView{
        get {return _playView}
        set {_playView = newValue}
    }
    
    override func loadView()
    {
        _motionManager = CMMotionManager();
        _playView = PlayView();
        
        view = _playView;
        
        //MIDIInputPortCreate(<#T##client: MIDIClientRef##MIDIClientRef#>, <#T##portName: CFString##CFString#>, <#T##readProc: MIDIReadProc##MIDIReadProc##(UnsafePointer<MIDIPacketList>, UnsafeMutableRawPointer?, UnsafeMutableRawPointer?) -> Void#>, <#T##refCon: UnsafeMutableRawPointer?##UnsafeMutableRawPointer?#>, <#T##outPort: UnsafeMutablePointer<MIDIPortRef>##UnsafeMutablePointer<MIDIPortRef>#>)
        //MIDIPortConnectSource(<#T##port: MIDIPortRef##MIDIPortRef#>, <#T##source: MIDIEndpointRef##MIDIEndpointRef#>, <#T##connRefCon: UnsafeMutableRawPointer?##UnsafeMutableRawPointer?#>)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _:CMAccelerometerData!;
        let _:NSError!;
        
//        if(_motionManager.isDeviceMotionAvailable)
//        {
//            _motionManager.deviceMotionUpdateInterval = 0.07;
//           
//            _motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {
//                
//                accelerometerData, error in
//                //-> Void in
//                //self.outputAcclerationData(accelerometerData.acceleration)
//                let acceleration = accelerometerData!.userAcceleration
//                let rotation = accelerometerData!.rotationRate;           
//                
//                if(error != nil)
//                {
//                    print("error with DeviceMotionUpdates: " + error.debugDescription);
//                }
//                else if( ( (acceleration.z) < -self._accelThreshold) && (abs(rotation.x) + abs(rotation.y) + abs(rotation.z) < 1) )
//                //else if(rotation.x == 0 && rotation.y == 0 && rotation.z == 0)
//                {
//                    print("Accel x: "  + acceleration.x.debugDescription);
//                    print("Accel y: "  + acceleration.y.debugDescription);
//                    print("Accel z: "  + acceleration.z.debugDescription);
//                    
//                    self._playView.pressPlay();
//                }
//            })
//            
//        }
        
//        if(_motionManager.isDeviceMotionAvailable)
//        {
//            //_motionManager.deviceMotionUpdateInterval = 0.07;
//            _motionManager.magnetometerUpdateInterval = 0.07;
//            
//            _motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {
//                
//                //accelerometerData, error in
//                magnetometerData, error in
//                //-> Void in
//                //self.outputAcclerationData(accelerometerData.acceleration)
//                //let acceleration = accelerometerData!.userAcceleration
//                //let rotation = accelerometerData!.rotationRate;
//                
//                let accuracy = magnetometerData?.magneticField.accuracy;
//                
//                if(error != nil)
//                {
//                    print("error with DeviceMotionUpdates: " + error.debugDescription);
//                }
////                else if( ( (acceleration.z) < -self._accelThreshold) && (abs(rotation.x) + abs(rotation.y) + abs(rotation.z) < 1) )
////                    //else if(rotation.x == 0 && rotation.y == 0 && rotation.z == 0)
////                {
////                    print("Accel x: "  + acceleration.x.debugDescription);
////                    print("Accel y: "  + acceleration.y.debugDescription);
////                    print("Accel z: "  + acceleration.z.debugDescription);
////                    
////                    self._playView.pressPlay();
////                }
////                else if(magnetometerData?.magneticField == 1.0)
////                {
////                    
////                }
//                //else if(magnetometerData!.magneticField.field.x > 0.001)
//                //{
//                    print("Accuracy: " + accuracy!.rawValue.description);
//                    print("magnetic field x: " + (magnetometerData?.magneticField.field.x.debugDescription)!);
//                    print("magnetic field y: " + (magnetometerData?.magneticField.field.y.debugDescription)!);
//                    print("magnetic field z: " + (magnetometerData?.magneticField.field.z.debugDescription)!);
//                    
//                    //magnetometerData?.gravity
//                //}
//                
//                
//            })
//            
//        }
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

