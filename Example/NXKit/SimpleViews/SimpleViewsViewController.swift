//
//  SimpleViewsViewController.swift
//  NXKit_Example
//
//  Created by Austin Chen on 2018-08-01.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import AppKit
import NXKit

class SimpleViewsViewController: NSViewController {
    
    @IBOutlet weak var simpleView: NXView!
    @IBOutlet weak var button: NSButton!
    @IBAction func buttonTapped(_ sender: Any) {
        menu1.popUp(positioning: nil, at: button.frame.origin, in: view)
    }
    
    @IBOutlet var menu1: NSMenu!
    @IBOutlet weak var disabledTextfield: NSTextField!
    
    private var eventMonitor: EventMonitor?
    private var eventTokenBag = ACEventMonitorTokenBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        disabledTextfield.font = NSFont.systemFont(ofSize: 20)
        disabledTextfield.disableInteraction(true)
        
        // detect mouse click on other application, so to close the popover
        eventMonitor = EventMonitor(mask: [.leftMouseDown, .rightMouseDown]) { event in
            print(event)
            return event
        }
        // eventMonitor?.start() // uncomment to start listen to mouse click
        
        simpleView.accepts1stResponder = true
        simpleView.addTarget(self, action: { (event, info) in
            if case .keyDown? = event,
                let key = info as? KeyCode.RawType
            {
                if key == KeyCode.s {
                    print(key)
                }
                print(key)
            }
        }, for: .keyDown)
    }
    
    deinit {
        eventMonitor?.stop()
    }
}
