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

//        vc.imageLoader = imageViewLoadCached
//        vc.imagePaths = [ "MyOyster", "CameraCube", "PixelPicker", "PerfectGrid" ]

        vc.imageLoader = imageViewLoadFromPath
        vc.imagePaths = [
            // Zoopla.co.uk
            "http://li.zoocdn.com/ae426ea12c52e042bd0af2fc02c3a2904732f186_645_430.jpg",
            "http://li.zoocdn.com/bb3d7c42506f563c1174828c97522728a87cfae8_645_430.jpg",
            "http://li.zoocdn.com/162fd32ce15911cba3dcdf27a8a37238708991bc_645_430.jpg",
            "http://li.zoocdn.com/9e17e58963944f4a6695c56561f1bd4ee0803cba_645_430.jpg",
            "http://li.zoocdn.com/ffdbb7c884427a1d599f052cae4f205bf63373cf_645_430.jpg",
        ]
        // Then, add to view hierarchy
        vc.addAsChildViewController(self, attachToView:self.containerView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

