//
//  ACTokenBagMisc.swift
//  <?>App
//
//  Created by Austin Chen on 2017-06-29.
//  Copyright © 2017 10.1. All rights reserved.
//

import Foundation

// observer token
public extension NSObjectProtocol {
    public func addDisposableToken(to noteObserverBag: ACNoteObserverTokenBag) {
        noteObserverBag.addToken(self)
    }
}

open class ACNoteObserverTokenBag: ACTokenBag {
    
    open override func removeAllTokens() {
        // must be called when observer callback is deallocated, otherwise triggering this note will crash
        tokens.forEach{ NotificationCenter.default.removeObserver($0) }
        
        super.removeAllTokens()
    }
}

// monitor token
public extension NSEvent {
    public func addDisposableToken(to eventMonitorBag: ACEventMonitorTokenBag) {
        eventMonitorBag.addToken(self)
    }
}

open class ACEventMonitorTokenBag: ACTokenBag {
    open override func removeAllTokens() {
        tokens.forEach{ NSEvent.removeMonitor($0) } // need to set $0 to nil?
        
        super.removeAllTokens()
    }
}
