// MVCarouselCell.swift
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

public class MVCarouselCell: UICollectionViewCell {
 
    @IBOutlet weak var scrollView : MVCarouselCellScrollView!
    var cellSize : CGSize {
        get {
            return scrollView.cellSize
        }
        set {
            scrollView.cellSize = newValue
        }
    }
    var maximumZoom : Double {
        get {
            return scrollView.maximumZoom
        }
        set {
            scrollView.maximumZoom = newValue
        }
    }
    var imagePath : String {
        get {
            return scrollView.imagePath
        }
        set {
            scrollView.imagePath = newValue
        }
    }
    
    var imageLoader: MVImageLoaderClosure? {
        get {
            return scrollView.imageLoader
        }
        set {
            scrollView.imageLoader = newValue
        }
    }

    func resetZoom() {
        scrollView.resetZoom()
    }
}
