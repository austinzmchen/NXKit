//
//  SimpleCollectionViewController.swift
//  NXKit_Example
//
//  Created by Austin Chen on 2019-04-12.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import AppKit

class SimpleCollectionViewController: NSViewController {
    
    @IBOutlet weak var collectionView: NSCollectionView!
    @IBAction func showSectionsChecked(_ sender: NSButton) {
        let show = sender.state
        imageDirectoryLoader.singleSectionMode = (show == .off)
        imageDirectoryLoader.setupDataForUrls(nil)
        collectionView.reloadData()
    }
    
    let imageDirectoryLoader = ImageDirectoryLoader()
    
    override func viewDidLoad() {
        let initialFolderUrl = URL(fileURLWithPath: "/Library/Desktop Pictures", isDirectory: true)
        imageDirectoryLoader.loadDataForFolderWithUrl(initialFolderUrl)
        
        //High Sierra, NSCollectionView does not scroll items past initial visible rect
        if #available(OSX 10.13, *) {
            if let contentSize = self.collectionView.collectionViewLayout?.collectionViewContentSize {
                self.collectionView.setFrameSize(contentSize)
            }
        }
        self.collectionView.reloadData()
    }
}

extension SimpleCollectionViewController:
    NSCollectionViewDataSource,
    NSCollectionViewDelegate
{
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        return imageDirectoryLoader.numberOfSections
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageDirectoryLoader.numberOfItemsInSection(section)
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
        let item = collectionView.makeItem(withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "SimpleCollectionViewItem"), // this identifier must be the class name ?!
                                           for: indexPath) as! SimpleCollectionViewItem
        
        let imageFile = imageDirectoryLoader.imageFileForIndexPath(indexPath)
        item.imgView?.image = imageFile.thumbnail
        item.titleField?.stringValue = imageFile.fileName
        
        return item
    }
    
    func collectionView(_ collectionView: NSCollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> NSView {
        let view = collectionView.makeSupplementaryView(ofKind: NSCollectionView.elementKindSectionHeader, withIdentifier: NSUserInterfaceItemIdentifier(rawValue: "HeaderView"), for: indexPath) as! HeaderView
        
        view.sectionTitle.stringValue = "Section \(indexPath.section)"
        let numberOfItemsInSection = imageDirectoryLoader.numberOfItemsInSection(indexPath.section)
        view.imageCount.stringValue = "\(numberOfItemsInSection) image files"
        return view
    }
}

extension SimpleCollectionViewController : NSCollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: NSCollectionView, layout collectionViewLayout: NSCollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> NSSize {
        return imageDirectoryLoader.singleSectionMode ? NSZeroSize : NSSize(width: 1000, height: 40)
    }
}
