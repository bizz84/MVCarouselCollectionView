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
        vc.addAsChildViewController(self, attachToView:self.containerView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

