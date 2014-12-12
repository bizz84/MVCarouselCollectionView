//
//  MVCarouselCellScrollView.swift
//  MVCarouselCollectionView
//
//  Created by Andrea Bizzotto on 10/12/2014.
//  Copyright (c) 2014 Muse Visions. All rights reserved.
//

import UIKit

class MVCarouselCellScrollView: UIScrollView, UIScrollViewDelegate {

    var cellSize : CGSize = CGSizeZero
    var imagePath : String = "" {
        didSet {
            self.imageLoad?(imageView : self.imageView, imagePath: imagePath, completion: {
                (newImage) in
                self.resetZoom()
            })
        }
    }
    var imageLoad: ((imageView: UIImageView, imagePath : String, completion: (newImage: Bool) -> ()) -> ())? = nil
    
    @IBOutlet weak private var imageView : UIImageView!
    @IBOutlet weak private var activityIndicator : UIActivityIndicatorView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.delegate = self
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
        
        //self.activityIndicator.color = UIColor.blackColor()
    }

    func resetZoom() {
        if self.imageView.image == nil {
            return
        }
        var imageSize = self.imageView.image!.size
        
        // nothing to do if image is not set
        if CGSizeEqualToSize(imageSize, CGSizeZero) {
            return
        }
        
        // Stack overflow people suggest this, not sure if it applies to us
        self.imageView.contentMode = UIViewContentMode.Center
        if cellSize.width > imageSize.width && cellSize.height > imageSize.height {
            self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
        }
        
        var cellAspectRatio : CGFloat = self.cellSize.width / self.cellSize.height
        var imageAspectRatio : CGFloat = imageSize.width / imageSize.height
        var cellAspectRatioWiderThanImage = cellAspectRatio > imageAspectRatio
        
        // Calculate Zoom
        // If image is taller, then make edge to edge height, else make edge to edge width
        var zoom = cellAspectRatioWiderThanImage ? cellSize.height / imageSize.height : cellSize.width / imageSize.width
        
        self.maximumZoomScale = zoom * 4
        self.minimumZoomScale = zoom
        self.zoomScale = zoom
        
        // Update content inset
        var adjustedContentWidth = cellSize.height * imageAspectRatio
        var horzContentInset = cellAspectRatioWiderThanImage ? 0.5 * (cellSize.width - adjustedContentWidth) : 0.0
        var adjustedContentHeight = cellSize.width / imageAspectRatio
        var vertContentInset = !cellAspectRatioWiderThanImage ? 0.5 * (cellSize.height - adjustedContentHeight) : 0.0
    
        self.contentInset = UIEdgeInsetsMake(vertContentInset, horzContentInset, vertContentInset, horzContentInset)
    
    //NSLog(@"imageSize: %@, contentSize: %@, content offset: %@, cell ratio %@ image ratio, inset(horz: %f, vert: %f)", NSStringFromCGSize(imageSize), NSStringFromCGSize(self.contentSize), NSStringFromCGPoint(self.contentOffset), cellAspectRatioWiderThanImage ? @">" : @"<", horzContentInset, vertContentInset);
    }

    func viewForZoomingInScrollView(scrollView : UIScrollView) -> UIView {
        return self.imageView
    }
}
