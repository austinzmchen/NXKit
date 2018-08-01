//
//  TargetActionable.swift
//  RememBear
//
//  Created by Austin Chen on 2018-07-16.
//  Copyright © 2018 TunnelBear. All rights reserved.
//

import Foundation

public enum NXViewControlEvent {
  case mouseEntered
  case mouseExited
  
  case focused
  case unfocused
}

public typealias NXViewControlEventAction = () -> Void
public typealias NXViewControlRecord = (target: AnyObject, action: NXViewControlEventAction, event: NXViewControlEvent)

public protocol TargetActionable {
  var controlRecords: [NXViewControlRecord] {get set}
  mutating func addTarget(_ target: AnyObject, action: @escaping NXViewControlEventAction, for controlEvent: NXViewControlEvent)
  mutating func removeTarget(_ target: AnyObject, for controlEvent: NXViewControlEvent)
}

public extension TargetActionable {
  
  mutating func addTarget(_ target: AnyObject, action: @escaping NXViewControlEventAction, for controlEvent: NXViewControlEvent) {
    self.controlRecords.append( (target: target, action: action, event: controlEvent) )
  }

  mutating func removeTarget(_ target: AnyObject, for controlEvent: NXViewControlEvent) {
    #if swift(>=4.2)
      controlRecords.removeAll { (record) -> Bool in
        if record.target === target,
          record.event == controlEvent {
          return true
        }
        return false
      }
    #else
      /* Only for swift 4.1 and below
       Note: filter does not work as it creates a new array; reverse is safe as it does not change index of the rest of the elements
       */
      for (i, record) in controlRecords.enumerated().reversed() {
        if record.target === target,
          record.event == controlEvent {
          self.controlRecords.remove(at: i)
        }
      }
    #endif
  }
  
  func notifyTargets(_ event: NXViewControlEvent) {
    controlRecords.filter{
        if $0.event == event {
          return true
        } else {
          return false
        }
      }.forEach {
        $0.action()
      }
  }
}
