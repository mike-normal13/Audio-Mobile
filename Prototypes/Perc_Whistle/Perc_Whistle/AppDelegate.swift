//
//  AppDelegate.swift
//  Perc_Whistle
//
//  Created by mike on 11/11/16.
//  Copyright © 2016 mike. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import CoreBluetooth

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var _viewController: ViewController! = nil;
    var _audioSession: AVAudioSession! = nil;
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        _viewController = ViewController();
        
        // TODO: these lines may not be necessary
        //window = UIWindow(frame: UIScreen.main.bounds)
        //window?.rootViewController = UINavigationController(rootViewController: _viewController);
        
        window?.makeKeyAndVisible();
        
        _audioSession = AVAudioSession.sharedInstance()
        
        // reduce audio latency
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
        
        
        // TODO: Audio route change handling is not working with AudioKit for some reason......????
        
//        NotificationCenter.default.addObserver(forName:
//        .AVAudioSessionRouteChange, object: nil, queue: nil) {
//            
//            n in
//            
//            //NSLog("change route %@", n.userInfo!)// This is coming up nil for some reason!!!
//            
//            //print("current route \(AVAudioSession.sharedInstance().currentRoute)")// This is coming up nil for some reason!!!
//            print("nil?")
//            do
//            {
//                
//                //var preStart = self._viewController.playView.playSound.engine.isRunning;
//                var preStart = self._viewController.playView.playSound.isAudioKitRunning()
//                print("PreStart: " + preStart.description);
//                //try self._viewController.playView.playSound.engine.start();
//                try self._viewController.playView.playSound.restartAudioKit();
//                //var postStart = self._viewController.playView.playSound.engine.isRunning;
//                var postStart = self._viewController.playView.playSound.isAudioKitRunning();
//                print("PostStart: " + postStart.description);
//                
//            }
//            catch
//            {
//                print("restarting the audio engine after route change had problem")
//            }
//            
//        }
//        
//        NotificationCenter.default.addObserver(forName:
//        .AVAudioSessionInterruption, object: nil, queue: nil) {
//            n in
//            let why = AVAudioSessionInterruptionType(rawValue:
//                n.userInfo![AVAudioSessionInterruptionTypeKey] as! UInt)!
//            if why == .began {
//                print("interruption began:\n\(n.userInfo!)")
//            } else {
//                print("interruption ended:\n\(n.userInfo!)")
//                guard let opt = n.userInfo![AVAudioSessionInterruptionOptionKey] as? UInt else {return}
//                if AVAudioSessionInterruptionOptions(rawValue:opt).contains(.shouldResume) {
//                    print("should resume")
//                } else {
//                    print("not should resume")
//                }
//            }
//        }
        
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
//        _viewController.playView.playControl.mic.stop()
//        _viewController.playView.playSound.stopAudioKit()
//        _viewController.playView.playControl.stopAudioKit()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
//        _viewController.playView.playControl.mic.stop()
//        _viewController.playView.playSound.stopAudioKit()
//        _viewController.playView.playControl.stopAudioKit()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        //_viewController.playView.playControl.mic.stop()
        self.saveContext()
//        _viewController.playView.playControl.mic.stop()
//        _viewController.playView.playSound.stopAudioKit()
//        _viewController.playView.playControl.stopAudioKit()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Perc_Whistle")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

