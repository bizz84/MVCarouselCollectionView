//
//  MVCarouselCollectionView.swift
//  MVCarouselCollectionView
//
//  Created by Andrea Bizzotto on 10/12/2014.
//  Copyright (c) 2014 Muse Visions. All rights reserved.
//

import UIKit
import Foundation

@objc protocol MVCarouselCollectionViewDelegate {
    func didSelectCellAtIndexPath(indexPath: NSIndexPath)
    func didScrollToCellAtIndex(pageIndex : NSInteger)
}

class MVCarouselCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
 
    private let reuseID = "SomeReuseID"
    
    // MARK: Variables
    var imagePaths : [String] = [] {
        didSet {
            self.reloadData()
        }
    }
    
    var selectDelegate : MVCarouselCollectionViewDelegate?
    var currentPageIndex : Int = 0
    
    var imageLoad: ((imageView: UIImageView, imagePath : String, completion: (newImage: Bool) -> ()) -> ())? = imageViewLoad

    private var clientDidRequestScroll : Bool = false

    // MARK: Initialisation
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.delegate = self
        self.dataSource = self
    
        var nib = UINib(nibName : "MVCarouselCell", bundle: nil)
        self.registerNib(nib, forCellWithReuseIdentifier: self.reuseID)
    }
    
    // MARK: UICollectionViewDataSource
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imagePaths.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(self.reuseID, forIndexPath: indexPath) as MVCarouselCell
        cell.cellSize = self.bounds.size
        cell.imageLoad = self.imageLoad
        cell.imagePath = self.imagePaths[indexPath.row]
        
        // http://stackoverflow.com/questions/16960556/how-to-zoom-a-uiscrollview-inside-of-a-uicollectionviewcell
        if let gestureRecognizer = cell.scrollView.pinchGestureRecognizer {
            self.addGestureRecognizer(gestureRecognizer)
        }
        if let gestureRecognizer = cell.scrollView?.panGestureRecognizer {
            self.addGestureRecognizer(gestureRecognizer)
        }
    
        return cell
    }
    
    func collectionView(collectionView : UICollectionView, didEndDisplayingCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {

        if let mcell = cell as? MVCarouselCell {
            // http://stackoverflow.com/questions/16960556/how-to-zoom-a-uiscrollview-inside-of-a-uicollectionviewcell
            if let gestureRecognizer = mcell.scrollView?.pinchGestureRecognizer {
                self.removeGestureRecognizer(gestureRecognizer)
            }
            if let gestureRecognizer = mcell.scrollView?.panGestureRecognizer {
                self.removeGestureRecognizer(gestureRecognizer)
            }
        }
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(collectionView : UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    
        return self.bounds.size
    }
    
    func collectionView(collectionView : UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.selectDelegate?.didSelectCellAtIndexPath(indexPath)
    }

    // MARK: UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
    
        if scrollView == self {
            if !self.clientDidRequestScroll {
                self.updatePageIndex()
            }
        }
    }
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        if scrollView == self {
            self.clientDidRequestScroll = false
            self.updatePageIndex()
        }
    }
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        if scrollView == self {
            self.clientDidRequestScroll = false
            self.updatePageIndex()
        }
    }
    
    func updatePageIndex() {
        var pageIndex = self.getPageNumber()
        if currentPageIndex != pageIndex {
//            println("old page: \(currentPageIndex), new page: \(pageIndex)")
            currentPageIndex = pageIndex
            self.selectDelegate?.didScrollToCellAtIndex(pageIndex)
        }
    }
    
    func getPageNumber() -> NSInteger {
        
        // http://stackoverflow.com/questions/4132993/getting-the-current-page
        var width : CGFloat = self.frame.size.width
        var page : NSInteger = NSInteger((self.contentOffset.x + (CGFloat(0.5) * width)) / width)
        var numPages = self.numberOfItemsInSection(0)
        if page < 0 {
            page = 0
        }
        else if page >= numPages {
            page = numPages - 1
        }
        return page
    }
    
    func setCurrentPageIndex(pageIndex: Int, animated: Bool) {
        self.currentPageIndex = pageIndex
        self.clientDidRequestScroll = true;
        
        var indexPath = NSIndexPath(forRow: currentPageIndex, inSection: 0)
        self.scrollToItemAtIndexPath(indexPath, atScrollPosition:UICollectionViewScrollPosition.CenteredHorizontally, animated:true)
    }


    func resetZoom() {
        for cell in self.visibleCells() {
            cell.resetZoom()
        }
    }
}
