// ViewController.swift
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

class ViewController: UIViewController {

    @IBOutlet var containerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        var storyboard = UIStoryboard(name: "CarouselStoryboard", bundle: nil)
        var vc : MVEmbeddedCarouselViewController = storyboard.instantiateInitialViewController() as! MVEmbeddedCarouselViewController

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

