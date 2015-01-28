MVCarouselCollectionView
=========================
UICollectionView-based image carousel written in Swift

Preview
-------------------------------------------------------

![MVCarouselCollectionView preview](https://github.com/bizz84/MVCarouselCollectionView/raw/master/preview.gif "MVCarouselCollectionView preview")

Features
-------------------------------------------------------

- Horizontal-scrolling carousel with pinch & zoom capabilities
- Works both with local and remote images 
- Embedded or full-screen mode

Installation
-------------------------------------------------------

If you are using Cocoapods, simply add the line below to your Podfile, then type 'pod install':

<pre>
pod 'MVCarouselCollectionView'
</pre>

Usage
-------------------------------------------------------

<pre>
class CarouselViewController: UIViewController, MVCarouselCollectionViewDelegate {

    // Local images
    var imagePaths : [ "image1.png", "image2.png", "image3.png" ]
    // Closure to load local images with UIImage.named
    var imageLoader: ((imageView: UIImageView, imagePath : String, completion: (newImage: Bool) -> ()) -> ()) = {
      (imageView: UIImageView, imagePath : String, completion: (newImage: Bool) -> ()) in

        imageView.image = UIImage(named:imagePath)
        completion(newImage: imageView.image != nil)
    }

    @IBOutlet var collectionView : MVCarouselCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureCollectionView()
    }
    
    func configureCollectionView() {
    
        collectionView.selectDelegate = self
        collectionView.imagePaths = imagePaths
        collectionView.commonImageLoader = self.imageLoader
        collectionView.maximumZoom = 2.0
        collectionView.reloadData()
    }
    // MARK:  MVCarouselCollectionViewDelegate
    func didSelectCellAtIndexPath(indexPath : NSIndexPath) {
    
        // Do something with cell selection
    }
    
    func didScrollToCellAtIndex(pageIndex: NSInteger) {
    
        // Page changed, can use this to update page control
    }
}
</pre>

Requirements
-------------------------------------------------------
MVCarouselCollectionView requires iOS 8.0 or greater.


License
-------------------------------------------------------
Copyright (c) 2015 Andrea Bizzotto bizz84@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
