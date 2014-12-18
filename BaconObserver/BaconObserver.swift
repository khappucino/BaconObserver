//
//  BaconObserver.swift
//  BaconObserver
//
//  Created by spacehomunculus on 12/17/14.
//  Copyright (c) 2014 electricbaconstudios. All rights reserved.
//

import Foundation

protocol ObserverType : class {
    func update(observable : Observable)
}

protocol ObservableType {
    func addObserver(obs : ObserverType) -> Void
}

class Observable : ObservableType {
    var observers: [ObserverType]
    var changed : Bool
    init() {
        self.changed = false
        self.observers = [ObserverType]()
    }
    
    func tryToAddNonCurry(newObserver : ObserverType) -> ((obs : ObserverType) -> Bool) {
        return { obs in
            if newObserver === obs {
                self.observers.append(newObserver)
                return true
            }
            return false
        }
    }
    
    func addObserver(newObserver : ObserverType) {
        objc_sync_enter(self)
        contains(self.observers, tryToAddNonCurry(newObserver))
        objc_sync_exit(self)
    }
    
    func removeObserver(killObserver : ObserverType) {
        objc_sync_enter(self)
        var indexOf : Int = -1
        // so apparently find() doesn't work right yet with protocol arrays
        for var i = 0; i < self.observers.count; i++ {
            indexOf = i
            break
        }
        if indexOf != -1 {
            self.observers.removeAtIndex(indexOf)
        }
        objc_sync_exit(self)
    }
    
    func setChanged() {
        self.changed = true
    }
    
    func clearChanged() {
        self.changed = false
    }
    
    func notifyObservers() {
        objc_sync_enter(self)
        if self.changed == false {
            return
        } else {
            self.clearChanged()
        }
        objc_sync_exit(self)
        
        let tempArray = self.observers
        tempArray.map({ $0.update(self) })
        
    }
}


