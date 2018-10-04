//
//  NSControlPlus.swift
//  NXKit
//
//  Created by Austin Chen on 2018-10-03.
//

import AppKit

extension NSControl {
    open func addTarget(_ target: AnyObject?, action: Selector) {
        self.target = target
        self.action = action
    }
    
    open func removeTarget() {
        self.target = nil
        self.action = nil
    }
}
