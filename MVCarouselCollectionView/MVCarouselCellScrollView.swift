// MVCarouselCellScrollView.swift
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

// Image loader closure type
public typealias MVImageLoaderClosure = ((imageView: UIImageView, imagePath : String, completion: (newImage: Bool) -> ()) -> ())

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
        let imageSize = self.imageView.image!.size
        
        // nothing to do if image is not set
        if CGSizeEqualToSize(imageSize, CGSizeZero) {
            return
        }
        
        // Stack overflow people suggest this, not sure if it applies to us
        self.imageView.contentMode = UIViewContentMode.Center
        if cellSize.width > imageSize.width && cellSize.height > imageSize.height {
            self.imageView.contentMode = UIViewContentMode.ScaleAspectFit
        }
        
        let cellAspectRatio : CGFloat = self.cellSize.width / self.cellSize.height
        let imageAspectRatio : CGFloat = imageSize.width / imageSize.height
        let cellAspectRatioWiderThanImage = cellAspectRatio > imageAspectRatio
        
        // Calculate Zoom
        // If image is taller, then make edge to edge height, else make edge to edge width
        let zoom = cellAspectRatioWiderThanImage ? cellSize.height / imageSize.height : cellSize.width / imageSize.width
        
        self.maximumZoomScale = zoom * CGFloat(zoomToUse())
        self.minimumZoomScale = zoom
        self.zoomScale = zoom
        
        // Update content inset
        let adjustedContentWidth = cellSize.height * imageAspectRatio
        let horzContentInset = cellAspectRatioWiderThanImage ? 0.5 * (cellSize.width - adjustedContentWidth) : 0.0
        let adjustedContentHeight = cellSize.width / imageAspectRatio
        let vertContentInset = !cellAspectRatioWiderThanImage ? 0.5 * (cellSize.height - adjustedContentHeight) : 0.0
    
        self.contentInset = UIEdgeInsetsMake(vertContentInset, horzContentInset, vertContentInset, horzContentInset)
    }
    
    func zoomToUse() -> Double {
        return maximumZoom < 1.0 ? MaximumZoom : maximumZoom
    }

    func viewForZoomingInScrollView(scrollView : UIScrollView) -> UIView? {
        return self.imageView
    }
}
