//
//  SimpleCollectionViewItem.swift
//  NXKit_Example
//
//  Created by Austin Chen on 2019-04-12.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import AppKit

/*
 1. must connect the root view to file owner's view outlet in collectionViewItem's .xib
 2. must connect the root view to the Objects -> collectionViewItem
 */
class SimpleCollectionViewItem: NSCollectionViewItem {
    /*
        Must connect from file owner's IBOutlets to rootView's respective views
     */
    @IBOutlet weak var imgView: NSImageView!
    @IBOutlet weak var titleField: NSTextField!
}
