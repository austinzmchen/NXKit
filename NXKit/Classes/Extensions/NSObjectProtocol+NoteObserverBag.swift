//
//  NSObjectProtocol+ObserverBag.swift
//  HailApp
//
//  Created by Austin Chen on 2017-06-29.
//  Copyright © 2017 10.1. All rights reserved.
//

import Foundation

extension NSObjectProtocol {
    public func addDisposableToken(to noteObserverBag: ACNoteObserverTokenBag) {
        noteObserverBag.addToken(self)
    }
}
