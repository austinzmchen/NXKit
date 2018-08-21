//
//  Hoverable.swift
//  SharedFramework
//
//  Created by Rodrigue Hajjar on 2017-11-13.
//  Copyright © 2017 TunnelBear. All rights reserved.
//

import AppKit

public protocol Hoverable {
  func hasHover() -> Bool
  func disableHover()
  func enableHover()
  
  func setHover(_ enabled: Bool)
}

public extension Hoverable where Self: NSView {
  
  func hasHover() -> Bool { return true }
  
  func enableHover() {
    let ta = NSTrackingArea.init(rect: bounds,
                                 options: [.mouseMoved,
                                           .mouseEnteredAndExited,
                                           .inVisibleRect,
                                           .activeInKeyWindow,
                                           .enabledDuringMouseDrag,
                                           .cursorUpdate],
                                 owner: self,
                                 userInfo: ["kCustomTrackArea": true])
    addTrackingArea(ta)
  }
  
  func disableHover() {
    let fta = trackingAreas.first{ $0.userInfo?["kCustomTrackArea"] != nil }
    if let fta = fta { removeTrackingArea(fta) }
  }
  
  func setHover(_ enabled: Bool) { /* do nothing as NSView reacts to UI events */}
}
