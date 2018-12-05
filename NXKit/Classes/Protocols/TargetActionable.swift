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
    
    case keyDown
    case keyUp
}

//extension NXViewControlEvent: Equatable {
//    public static func ==(lhs: NXViewControlEvent, rhs: NXViewControlEvent) -> Bool {
//        switch (lhs, rhs) {
//        case (.keyDown(_),.keyDown(_)): fallthrough
//        case (.keyUp(_),.keyUp(_)): fallthrough
//        case (focused, focused): fallthrough
//        case (unfocused, unfocused): fallthrough
//        case (mouseEntered, mouseEntered): fallthrough
//        case (mouseExited, mouseExited):
//            return true
//        default:
//            return false
//        }
//    }
//
//    public static func ===(lhs: NXViewControlEvent, rhs: NXViewControlEvent) -> Bool {
//        switch (lhs, rhs) {
//        case (.keyDown(_),.keyDown(_)): fallthrough
//        case (.keyUp(_),.keyUp(_)): fallthrough
//        case (focused, focused): fallthrough
//        case (unfocused, unfocused): fallthrough
//        case (mouseEntered, mouseEntered): fallthrough
//        case (mouseExited, mouseExited):
//            return true
//        default:
//            return false
//        }
//    }
//}

public typealias NXViewControlEventAction = (_ event: NXViewControlEvent?, _ info: Any?) -> Void

public struct NXViewControlRecord {
    let target: AnyObject // target uniquely identifies the record
    let action: NXViewControlEventAction
    let event: NXViewControlEvent
}

public protocol TargetActionable {
  var controlRecords: [NXViewControlRecord] {get set}
  mutating func addTarget(_ target: AnyObject, action: @escaping NXViewControlEventAction, for controlEvent: NXViewControlEvent)
  mutating func removeTarget(_ target: AnyObject, for controlEvent: NXViewControlEvent)
}

public extension TargetActionable {
  
  mutating func addTarget(_ target: AnyObject, action: @escaping NXViewControlEventAction, for controlEvent: NXViewControlEvent) {
    self.controlRecords.append( NXViewControlRecord(target: target, action: action, event: controlEvent) )
  }

  mutating func removeTarget(_ target: AnyObject, for controlEvent: NXViewControlEvent) {
    #if swift(>=4.2)
      controlRecords.removeAll { (record) -> Bool in
        if record.target === target,
            controlEvent == record.event
        {
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
  
func notifyTargets(_ event: NXViewControlEvent, _ info: Any? = nil) {
    controlRecords.filter{
        if $0.event == event {
          return true
        } else {
          return false
        }
      }.forEach {
        $0.action(event, info)
      }
  }
}
