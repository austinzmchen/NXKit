//
//  SimplePresentViewController.swift
//  SampleModalSheet
//
//  Created by Austin Chen on 2018-09-07.
//  Copyright © 2018 Austin Chen. All rights reserved.
//

import Cocoa

class SimplePresentViewController: NSViewController {
    // manual transitions:
    
    @IBAction func showButtonClicked(_ sender: Any) {
        let window = NSWindow(contentRect: .zero,
                                   styleMask: [.resizable, .miniaturizable, .closable, .titled],
                                   backing: .buffered, defer: false)
        let windowVC = NSWindowController(window: window)
        windowVC.contentViewController = createModalVC()
        
        
        if let screenFrame = NSScreen.main?.frame {
            var f = window.frame
            f.origin = CGPoint(x: (screenFrame.width - f.width) / 2, y: (screenFrame.height - f.height) / 2)
            window.setFrame(f, display: true)
        }
        windowVC.showWindow(self)
    }
    @IBAction func modalButtonClicked(_ sender: Any) {
        presentAsModalWindow(createModalVC())
    }
    @IBAction func popoverButtonClicked(_ sender: Any) {
        let button = sender as! NSButton
        present(createModalVC(),
                asPopoverRelativeTo: button.frame,
                of: button.superview!, //  NSBox
                preferredEdge: .minY,
                behavior: .transient)
    }
    @IBAction func sheetButtonClicked(_ sender: Any) {
        presentAsSheet(createModalVC())
    }
    @IBAction func customButtonClicked(_ sender: Any) {
        present(createModalVC(), animator: LighthousePresentationAnimator())
    }
    
    
    // misc buttons
    @IBAction func buttonClicked(_ sender: Any) {
        view.window?.beginSheet(modalWindowController.window!, completionHandler: { (response) in
            switch response {
            case .OK:
                print("ok")
            case .cancel:
                print("cancel")
            default: break
            }
        })
    }
    
    var modalWindowController: NSWindowController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    // MARK: instance methods
    func createModalVC() -> ModalViewController {
        return storyboard?.instantiateController(withIdentifier: "kModalViewController") as! ModalViewController
    }
}

