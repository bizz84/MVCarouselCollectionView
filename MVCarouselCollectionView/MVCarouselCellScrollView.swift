//
//  MVCarouselCellScrollView.swift
//  MVCarouselCollectionView
//
//  Created by Andrea Bizzotto on 10/12/2014.
//  Copyright (c) 2014 Muse Visions. All rights reserved.
//

import UIKit

// Image loader closure type
typealias MVImageLoaderClosure = ((imageView: UIImageView, imagePath : String, completion: (newImage: Bool) -> ()) -> ())

class MVCarouselCellScrollView: UIScrollView, UIScrollViewDelegate {

    let MaximumZoom = 4.0
    
    var cellSize : CGSize = CGSizeZero
    var maximumZoom = 0.0
    var imagePath : String = "" {
        didSet {
            assert(self.imageLoader != nil, "Image loader must be specified")
            self.imageLoader?(imageView : self.imageView, imagePath: imagePath, completion: {
                (newImage) in
                self.resetZoom()
            })
        }
    }
    var imageLoader: MVImageLoaderClosure?
    
    @IBOutlet weak private var imageView : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.delegate = self
        self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
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
        
        self.maximumZoomScale = zoom * CGFloat(zoomToUse())
        self.minimumZoomScale = zoom
        self.zoomScale = zoom
        
        // Update content inset
        var adjustedContentWidth = cellSize.height * imageAspectRatio
        var horzContentInset = cellAspectRatioWiderThanImage ? 0.5 * (cellSize.width - adjustedContentWidth) : 0.0
        var adjustedContentHeight = cellSize.width / imageAspectRatio
        var vertContentInset = !cellAspectRatioWiderThanImage ? 0.5 * (cellSize.height - adjustedContentHeight) : 0.0
    
        self.contentInset = UIEdgeInsetsMake(vertContentInset, horzContentInset, vertContentInset, horzContentInset)
    }
    
    func zoomToUse() -> Double {
        return maximumZoom < 1.0 ? MaximumZoom : maximumZoom
    }

    func viewForZoomingInScrollView(scrollView : UIScrollView) -> UIView {
        return self.imageView
    }
}
