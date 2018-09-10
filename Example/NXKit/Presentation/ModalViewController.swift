//
//  ModalWindowController.swift
//  SampleModalSheet
//
//  Created by Austin Chen on 2018-09-07.
//  Copyright © 2018 Austin Chen. All rights reserved.
//

import AppKit

class ModalViewController: NSViewController {
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        view.window?.sheetParent?.endSheet(view.window!, returnCode: .OK)
    }
    
    @IBOutlet weak var cancelButton: NSButton!
    @IBAction func cancelButtonClicked(_ sender: Any) {
        if let pvc = presentingViewController {
            pvc.dismiss(self)
        } else {
            view.window?.close()
        }
    }
    
    weak var delegate: NSViewController?
}
