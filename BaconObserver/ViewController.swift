//
//  ViewController.swift
//  BaconObserver
//
//  Created by spacehomunculus on 12/17/14.
//  Copyright (c) 2014 electricbaconstudios. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BaconObserverType {

    required init(coder aDecoder: NSCoder) {
        self.baco = BaconObservable()
        super.init(coder: aDecoder)
    }
    
    var baco : BaconObservable

    
    func update(observable: BaconObservable) {
       println("")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.baco.addObserver(self)
        self.baco.poke()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

