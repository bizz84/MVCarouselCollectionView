//
//  MVFullScreenCarouselViewController.swift
//  MVCarouselCollectionView
//
//  Created by Andrea Bizzotto on 12/12/2014.
//  Copyright (c) 2014 Muse Visions. All rights reserved.
//

import UIKit
import MVCarouselCollectionView

@objc protocol MVFullScreenCarouselViewControllerDelegate {

    func willCloseWithSelectedIndexPath(indexPath: NSIndexPath)
}

class MVFullScreenCarouselViewController: UIViewController, MVCarouselCollectionViewDelegate {

    var initialViewIndex : NSInteger = 0
    weak var delegate : MVFullScreenCarouselViewControllerDelegate?

    var imagePaths : [String] = []
    var imageLoader: ((imageView: UIImageView, imagePath : String, completion: (newImage: Bool) -> ()) -> ())?

    @IBOutlet var collectionView : MVCarouselCollectionView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionView.selectDelegate = self
        self.collectionView.commonImageLoader = self.imageLoader
        self.collectionView.imagePaths = self.imagePaths
        self.collectionView.maximumZoom = 4.0
        self.collectionView.reloadData()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
        //self.collectionView.reloadData()
        // Apparently on iOS 7 scrollToInitialIndex doesn't have an effect here. Using performSelector fixes it
        var timer = NSTimer.scheduledTimerWithTimeInterval(0.0, target: self, selector: Selector("scrollToInitialIndex"), userInfo: nil, repeats: false)
    }
    
    func scrollToInitialIndex() {

        var indexPath = NSIndexPath(forRow:self.initialViewIndex, inSection: 0)
        self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition:UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
    }
    
    // MARK: MVCarouselCollectionViewDelegate
    func didSelectCellAtIndexPath(indexPath : NSIndexPath) {
        
        self.delegate?.willCloseWithSelectedIndexPath(indexPath)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didScrollToCellAtIndex(pageIndex : NSInteger) {
        
        //DLogInfo(@"new page: %ld", (unsigned long)pageIndex);
    }

    @IBAction func closeButtonPressed(sender: AnyObject?) {

        var indexPath = NSIndexPath(forRow:self.collectionView.currentPageIndex, inSection: 0)
        self.delegate?.willCloseWithSelectedIndexPath(indexPath)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
