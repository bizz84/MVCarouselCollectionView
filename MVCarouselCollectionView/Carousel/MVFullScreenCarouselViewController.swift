//
//  MVFullScreenCarouselViewController.swift
//  MVCarouselCollectionView
//
//  Created by Andrea Bizzotto on 12/12/2014.
//  Copyright (c) 2014 Muse Visions. All rights reserved.
//

import UIKit

@objc protocol MVFullScreenCarouselViewControllerDelegate {

    func willCloseWithSelectedIndexPath(indexPath: NSIndexPath)
}

class MVFullScreenCarouselViewController: UIViewController, MVCarouselCollectionViewDelegate {

    var initialViewIndex : NSInteger = 0
    weak var delegate : MVFullScreenCarouselViewControllerDelegate?

    var imagePaths : [String] = []

    @IBOutlet var collectionView : MVCarouselCollectionView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.collectionView.selectDelegate = self
        
        self.collectionView.imagePaths = self.imagePaths
    }
    
    // MARK: MVCarouselCollectionViewDelegate
    func didSelectCellAtIndexPath(indexPath : NSIndexPath) {
    
        self.delegate?.willCloseWithSelectedIndexPath(indexPath)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func didScrollToCellAtIndex(pageIndex : NSInteger) {
    
    //DLogInfo(@"new page: %ld", (unsigned long)pageIndex);
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    
        // Apparently on iOS 7 scrollToInitialIndex doesn't have an effect here. Using performSelector fixes it
        self.scrollToInitialIndex()
        //[self performSelector:@selector(scrollToInitialIndex) withObject:nil afterDelay:0];
    }
    
    func scrollToInitialIndex() {

        var indexPath = NSIndexPath(forRow:self.initialViewIndex, inSection: 0)
        self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition:UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
    }
    
    @IBAction func closeButtonPressed(sender: AnyObject?) {

        var indexPath = NSIndexPath(forRow:self.collectionView.currentPageIndex, inSection: 0)
        self.delegate?.willCloseWithSelectedIndexPath(indexPath)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
