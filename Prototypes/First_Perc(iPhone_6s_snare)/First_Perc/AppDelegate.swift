//
//  AppDelegate.swift
//  First_Perc
//
//  Created by mike on 9/19/16.
//  Copyright © 2016 mike. All rights reserved.
//

// TODO: need to figure out why the thing aborts when you unplug from the headphone jack while the app is running.

import UIKit
import AVFoundation
import CoreBluetooth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var _viewController: ViewController! = nil;
    
    var _audioSession: AVAudioSession! = nil;


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        _viewController = ViewController();
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        //  TODO: need to set a root view controller
        window?.rootViewController = UINavigationController(rootViewController: _viewController);
        window?.makeKeyAndVisible();
        
        _audioSession = AVAudioSession.sharedInstance()
        
        
        do
        {
            //http://stackoverflow.com/questions/34680007/answer/submit#
            try _audioSession.setPreferredIOBufferDuration(0.001)
        }
        catch
        {
            print("Trouble with setting audio session's buffer duration!");
        }
        
        do
        {
            try _audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, with: AVAudioSessionCategoryOptions.allowBluetooth);
            
        }
        catch
        {
            print("Something went wrong with the bluetooth");
        }
        
        NotificationCenter.default.addObserver(forName:
        .AVAudioSessionRouteChange, object: nil, queue: nil) {
            n in
            NSLog("change route %@", n.userInfo!)
            print("current route \(AVAudioSession.sharedInstance().currentRoute)")
            
            //self._viewController.playView.playSound.engine.reset()
            
            do
            {
                var preStart = self._viewController.playView.playSound.engine.isRunning;
                print("PreStart: " + preStart.description);
                try self._viewController.playView.playSound.engine.start();
                var postStart = self._viewController.playView.playSound.engine.isRunning;
                print("PostStart: " + postStart.description);
            }
            catch
            {
                print("restarting the audio engine after route change had problem")
            }
            
        }
        
        NotificationCenter.default.addObserver(forName:
        .AVAudioSessionInterruption, object: nil, queue: nil) {
            n in
            let why = AVAudioSessionInterruptionType(rawValue:
                n.userInfo![AVAudioSessionInterruptionTypeKey] as! UInt)!
            if why == .began {
                print("interruption began:\n\(n.userInfo!)")
            } else {
                print("interruption ended:\n\(n.userInfo!)")
                guard let opt = n.userInfo![AVAudioSessionInterruptionOptionKey] as? UInt else {return}
                if AVAudioSessionInterruptionOptions(rawValue:opt).contains(.shouldResume) {
                    print("should resume")
                } else {
                    print("not should resume")
                }
            }
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

