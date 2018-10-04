//
//  NSApplicationPlus.swift
//  NXKit
//
//  Created by Austin Chen on 2018-09-28.
//

import Foundation

public extension NSApplication {
    public var appName: String? {
        return Bundle.main.infoDictionary?["CFBundleName"] as? String
    }
}
