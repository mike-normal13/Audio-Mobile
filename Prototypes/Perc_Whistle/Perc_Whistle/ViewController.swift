//
//  ViewController.swift
//  Perc_Whistle
//
//  Created by mike on 11/11/16.
//  Copyright © 2016 mike. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var _playView: PlayView! = nil;
    
    var playView: PlayView
        {
        get {return _playView}
        set {_playView = newValue}
    }
    
    override func loadView()
    {
        _playView = PlayView();
        view = _playView;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

