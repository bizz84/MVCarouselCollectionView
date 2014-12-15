//
//  ViewController.swift
//  MVCarouselCollectionView
//
//  Created by Andrea Bizzotto on 10/12/2014.
//  Copyright (c) 2014 Muse Visions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        var storyboard = UIStoryboard(name: "CarouselStoryboard", bundle: nil)
        var vc : MVEmbeddedCarouselViewController = storyboard.instantiateInitialViewController() as MVEmbeddedCarouselViewController

        // First configure data source
        //        self.collectionView.imageLoader = imageViewLoadFromPath
        //        self.imagePaths = [
        //            "https://farm4.staticflickr.com/3869/14537609860_c1ca6324c8_b_d.jpg",
        //            "https://farm6.staticflickr.com/5609/14994054683_62f40c1b37_b_d.jpg"
        //        ];
        vc.imageLoader = imageViewLoadCached
        vc.imagePaths = [ "MyOyster", "CameraCube", "PixelPicker", "PerfectGrid" ];

        // Then, add to view hierarchy
        vc.addAsChildViewController(self, attachToView:self.containerView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

