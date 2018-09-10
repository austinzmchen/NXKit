//
//  NSView+Focus.swift
//  NXKit
//
//  Created by Austin Chen on 2018-08-28.
//

import Foundation

protocol Focusable {
    var isFocused: Bool {get set}
}

extension NSView: Focusable {
    @objc public var isFocused: Bool {
        get {
            if let wd = window,
                wd.fieldEditor(false, for: self) == wd.firstResponder {
                return true
            }
            return false
        }
        
        set {
            window?.makeFirstResponder(self)
        }
    }
}
