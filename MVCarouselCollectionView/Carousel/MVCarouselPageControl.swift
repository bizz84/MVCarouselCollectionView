//
//  MVCarouselPageControl.swift
//  MVCarouselCollectionView
//
//  Created by Andrea Bizzotto on 12/12/2014.
//  Copyright (c) 2014 Muse Visions. All rights reserved.
//

import UIKit

class MVCarouselPageControl: UIPageControl {
   
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.pageIndicatorTintColor = UIColor.grayColor()
        self.currentPageIndicatorTintColor = UIColor.blackColor()
        self.hidesForSinglePage = true
    }
}
