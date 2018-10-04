//
//  ACTokenBag.swift
//  <?>App
//
//  Created by Austin Chen on 2017-08-01.
//  Copyright © 2017 ACCodeworks inc All rights reserved.
//

import Foundation

public protocol ACTokenBagType {
    func addToken(_ token: NSObjectProtocol)
    func removeAllTokens()
}

open class ACTokenBag {
    var tokens: [NSObjectProtocol] = [] //< The tokens registered with NSNotificationCenter
    
    deinit {
        removeAllTokens()
    }
    
    /// The Sync Coordinator holds onto tokens used to register with the NSNotificationCenter.
    func addToken(_ token: NSObjectProtocol) {
        tokens.append(token)
    }
    
    func removeAllTokens() {
        tokens.removeAll()
    }
}
