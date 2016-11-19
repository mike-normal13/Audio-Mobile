//
//  ViewController.swift
//  Perc-Shaker
//
//  Created by mike on 11/12/16.
//  Copyright © 2016 mike. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController, UIAccelerometerDelegate {
    
    private var _playSounds: PlaySounds! = nil;
    private var _motionManager: CMMotionManager! = nil;
    private var _accelThreshold = 0.3;

    override func loadView() {
        
        _playSounds = PlaySounds();
        _motionManager = CMMotionManager();
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let _:CMAccelerometerData!;
        let _:NSError!;
        
                if(_motionManager.isDeviceMotionAvailable)
                {
                    _motionManager.deviceMotionUpdateInterval = 0.1 ;
        
                    _motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {
        
                        accelerometerData, error in
                        
                        let acceleration = accelerometerData!.userAcceleration
                        //let rotation = accelerometerData!.rotationRate;
        
                        if(error != nil)
                        {
                            print("error with DeviceMotionUpdates: " + error.debugDescription);
                        }
                        //else if( ( (acceleration.x) < -self._accelThreshold) && (abs(rotation.x) + abs(rotation.y) + abs(rotation.z) < 1) )
                            else if(acceleration.z >  self._accelThreshold )
                        //else if(rotation.x == 0 && rotation.y == 0 && rotation.z == 0)
                        {
                            print("Accel x: "  + acceleration.x.debugDescription);
                            // print("Accel y: "  + acceleration.y.debugDescription);
                            //print("Accel z: "  + acceleration.z.debugDescription);
                            print(".");
                            //self._playSounds.triggerSound();
                            //var arr: [Int] = [Int]()
                            //arr.popLast()
                        }
                    })
                    
                }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

