//
//  MVEmbeddedCarouselViewController.swift
//  MVCarouselCollectionView
//
//  Created by Andrea Bizzotto on 12/12/2014.
//  Copyright (c) 2014 Muse Visions. All rights reserved.
//

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
       
        view.setTranslatesAutoresizingMaskIntoConstraints(false)

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
            if let vc = vc {
                vc.imageLoader = self.imageLoader
                vc.imagePaths = self.imagePaths
                vc.initialViewIndex = (sender as NSIndexPath).row
                vc.delegate = self
                //vc.title = self.parentViewController?.title
            }
        }
    }
    
    // MARK: FullScreenViewControllerDelegate
    func willCloseWithSelectedIndexPath(indexPath: NSIndexPath) {

        self.collectionView.resetZoom()
        self.collectionView.scrollToItemAtIndexPath(indexPath, atScrollPosition:UICollectionViewScrollPosition.CenteredHorizontally, animated:false)
    }
}
