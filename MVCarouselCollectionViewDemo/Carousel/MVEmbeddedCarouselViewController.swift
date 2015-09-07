// MVEmbeddedCarouselViewController.swift
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

class MVEmbeddedCarouselViewController: UIViewController, MVCarouselCollectionViewDelegate, MVFullScreenCarouselViewControllerDelegate {

    var imagePaths : [String] = []
    var imageLoader: ((imageView: UIImageView, imagePath : String, completion: (newImage: Bool) -> ()) -> ())?

    @IBOutlet var collectionView : MVCarouselCollectionView!
    @IBOutlet var pageControl : MVCarouselPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        view.translatesAutoresizingMaskIntoConstraints = false

        self.pageControl.numberOfPages = imagePaths.count
        // Configure collection view
        self.collectionView.selectDelegate = self
        self.collectionView.imagePaths = imagePaths
        self.collectionView.commonImageLoader = self.imageLoader
        self.collectionView.maximumZoom = 2.0
        self.collectionView.reloadData()
    }
    
    func addAsChildViewController(parentViewController : UIViewController, attachToView parentView: UIView) {

        parentViewController.addChildViewController(self)
        self.didMoveToParentViewController(parentViewController)
        parentView.addSubview(self.view)
        self.autoLayout(parentView)
    }

    func autoLayout(parentView: UIView) {
    
        self.matchLayoutAttribute(.Left, parentView:parentView)
        self.matchLayoutAttribute(.Right, parentView:parentView)
        self.matchLayoutAttribute(.Bottom, parentView:parentView)
        self.matchLayoutAttribute(.Top, parentView:parentView)
    }
    
    func matchLayoutAttribute(attribute : NSLayoutAttribute, parentView: UIView) {

        parentView.addConstraint(
        NSLayoutConstraint(item:self.view, attribute:attribute, relatedBy:NSLayoutRelation.Equal, toItem:parentView, attribute:attribute, multiplier:1.0, constant:0))
    }
    
    // MARK:  MVCarouselCollectionViewDelegate
    func carousel(carousel: MVCarouselCollectionView, didSelectCellAtIndexPath indexPath: NSIndexPath) {

        // Send indexPath.row as index to use
        self.performSegueWithIdentifier("FullScreenSegue", sender:indexPath);
    }

    func carousel(carousel: MVCarouselCollectionView, didScrollToCellAtIndex cellIndex : NSInteger) {

        self.pageControl.currentPage = cellIndex
    }
    
    // MARK: IBActions
    @IBAction func pageControlEventChanged(sender: UIPageControl) {

        self.collectionView.setCurrentPageIndex(sender.currentPage, animated: true)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == "FullScreenSegue" {
        
            let nc = segue.destinationViewController as? UINavigationController
            let vc = nc?.viewControllers[0] as? MVFullScreenCarouselViewController
            if let vc = vc {
                vc.imageLoader = self.imageLoader
                vc.imagePaths = self.imagePaths
                vc.delegate = self
                vc.title = self.parentViewController?.navigationItem.title
                if let indexPath = sender as? NSIndexPath {
                    vc.initialViewIndex = indexPath.row
                }
            }
        }
    }
    
    // MARK: FullScreenViewControllerDelegate
    func willCloseWithSelectedIndexPath(indexPath: NSIndexPath) {

        self.collectionView.resetZoom()
        self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition:UICollectionViewScrollPosition.CenteredHorizontally, animated:false)
    }
}
