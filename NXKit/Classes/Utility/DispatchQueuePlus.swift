//
//  Time.swift
//  NXKit
//
//  Created by Austin Chen on 2018-08-28.
//

import Foundation

public extension DispatchQueue {
    public func delay(inSeconds seconds: Double, _ closure: @escaping ()->()) {
        let when = DispatchTime.now() + seconds
        asyncAfter(deadline: when, execute: closure)
    }
}
