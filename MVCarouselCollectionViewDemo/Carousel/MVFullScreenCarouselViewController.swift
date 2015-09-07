// MVFullScreenCarouselViewController.swift
//
// Copyright (c) 2015 Andrea Bizzotto (bizz84@gmail.com)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
        _ = NSTimer.scheduledTimerWithTimeInterval(0.0, target: self, selector: Selector("scrollToInitialIndex"), userInfo: nil, repeats: false)
    }
    
    func scrollToInitialIndex() {

        let indexPath = NSIndexPath(forRow:self.initialViewIndex, inSection: 0)
        self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition:UICollectionViewScrollPosition.CenteredHorizontally, animated: false)
    }
    
    // MARK: MVCarouselCollectionViewDelegate
    func carousel(carousel: MVCarouselCollectionView, didSelectCellAtIndexPath indexPath: NSIndexPath) {

        self.delegate?.willCloseWithSelectedIndexPath(indexPath)
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    func carousel(carousel: MVCarouselCollectionView, didScrollToCellAtIndex cellIndex : NSInteger) {

        //DLogInfo(@"new page: %ld", (unsigned long)pageIndex);
    }

    @IBAction func closeButtonPressed(sender: AnyObject?) {

        let indexPath = NSIndexPath(forRow:self.collectionView.currentPageIndex, inSection: 0)
        self.delegate?.willCloseWithSelectedIndexPath(indexPath)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
