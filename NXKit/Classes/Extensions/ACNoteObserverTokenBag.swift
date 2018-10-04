//
//  ACNoteObserverTokenBag.swift
//  <?>App
//
//  Created by Austin Chen on 2017-06-29.
//  Copyright © 2017 10.1. All rights reserved.
//

import Foundation

open class ACNoteObserverTokenBag: ACTokenBag {
    open override func removeAllTokens() {
        // must be called when observer callback is deallocated, otherwise triggering this note will crash
        tokens.forEach{ NotificationCenter.default.removeObserver($0) }
        
        super.removeAllTokens()
    }
}
