//
//  MVCarouselCell.swift
//  MVCarouselCollectionView
//
//  Created by Andrea Bizzotto on 10/12/2014.
//  Copyright (c) 2014 Muse Visions. All rights reserved.
//

import UIKit

class MVCarouselCell: UICollectionViewCell {
 
    @IBOutlet weak var scrollView : MVCarouselCellScrollView!
    var cellSize : CGSize {
        get {
            return scrollView.cellSize
        }
        set {
            scrollView.cellSize = newValue
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
