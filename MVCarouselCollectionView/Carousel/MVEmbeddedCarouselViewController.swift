//
//  MVEmbeddedCarouselViewController.swift
//  MVCarouselCollectionView
//
//  Created by Andrea Bizzotto on 12/12/2014.
//  Copyright (c) 2014 Muse Visions. All rights reserved.
//

import UIKit

class MVEmbeddedCarouselViewController: UIViewController, MVCarouselCollectionViewDelegate, MVFullScreenCarouselViewControllerDelegate {

    var imagePaths : [String] = [] {
        didSet {
            self.collectionView.imagePaths = imagePaths
            self.pageControl.numberOfPages = imagePaths.count
        }
    }

    @IBOutlet var collectionView : MVCarouselCollectionView!
    @IBOutlet var pageControl : MVCarouselPageControl!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       
        
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        self.collectionView.selectDelegate = self
        self.collectionView.imageLoad = imageViewLoadFromPath
        self.imagePaths = [
            "https://farm4.staticflickr.com/3869/14537609860_c1ca6324c8_b_d.jpg",
            "https://farm6.staticflickr.com/5609/14994054683_62f40c1b37_b_d.jpg"
        ];
        
//        self.collectionView.imageLoad = imageViewLoadCached
//        self.imagePaths = [ "MyOyster", "CameraCube", "PixelPicker", "PerfectGrid" ];
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
    func didSelectCellAtIndexPath(indexPath : NSIndexPath) {
    
        // Send indexPath.row as index to use
        self.performSegueWithIdentifier("FullScreenSegue", sender:indexPath);
    }
    
    func didScrollToCellAtIndex(pageIndex: NSInteger) {
    
        self.pageControl.currentPage = pageIndex
    }
    
    // MARK: IBActions
    @IBAction func pageControlEventChanged(sender: UIPageControl) {

        self.collectionView.setCurrentPageIndex(sender.currentPage, animated: true)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
        if segue.identifier == "FullScreenSegue" {
        
            var nc = segue.destinationViewController as? UINavigationController
            var vc = nc?.viewControllers[0] as? MVFullScreenCarouselViewController
            vc?.imagePaths = self.imagePaths
            vc?.initialViewIndex = (sender as NSIndexPath).row
            vc?.delegate = self
        }
    }
    
    // MARK: FullScreenViewControllerDelegate
    func willCloseWithSelectedIndexPath(indexPath: NSIndexPath) {

        self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition:UICollectionViewScrollPosition.CenteredHorizontally, animated:false)
    }
}
