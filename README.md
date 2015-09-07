MVCarouselCollectionView
=========================
UICollectionView-based image carousel written in Swift

Preview
-------------------------------------------------------

![MVCarouselCollectionView preview](https://github.com/bizz84/MVCarouselCollectionView/raw/master/preview.gif "MVCarouselCollectionView preview")

Features
-------------------------------------------------------

- Horizontal-scrolling carousel with pinch & zoom capabilities
- Synchronous or asynchronous image loading (works with local or remote images)
- Embedded or full-screen mode

Installation
-------------------------------------------------------

If you are using Cocoapods, simply add the line below to your Podfile, then type 'pod install':

<pre>
pod 'MVCarouselCollectionView'
</pre>

Alternatively, you can install this as a git submodule by following these steps:

* git submodule add https://github.com/bizz84/MVCarouselCollectionView.git
* Drag the MVCarouselCollectionView.xcodeproj file into your XCode project (XCode will ask to create a workspace file if your project does not have one already)
* Under the main app target, open the **General tab** and add MVCarouselCollectionView under the **Embedded Binaries** section
* Build the MVCarouselCollectionView target

Usage
-------------------------------------------------------

Below is a sample implementation of a view controller using MVCarouselCollectionView. See the demo application for a more advanced usage example.

```swift
import MVCarouselCollectionView

class CarouselViewController: UIViewController, MVCarouselCollectionViewDelegate {

    // Local images
    let imagePaths = [ "image1.png", "image2.png", "image3.png" ]
    // Closure to load local images with UIImage.named
    let imageLoader: ((imageView: UIImageView, imagePath : String, completion: (newImage: Bool) -> ()) -> ()) = {
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
    
        // NOTE: the collectionView IBOutlet class must be declared as MVCarouselCollectionView in Interface Builder, otherwise this will crash.
        collectionView.selectDelegate = self
        collectionView.imagePaths = imagePaths
        collectionView.commonImageLoader = self.imageLoader
        collectionView.maximumZoom = 2.0
        collectionView.reloadData()
    }
    // MARK:  MVCarouselCollectionViewDelegate
    func carousel(carousel: MVCarouselCollectionView, didSelectCellAtIndexPath indexPath: NSIndexPath) {

        // Do something with cell selection
    }
    
    func carousel(carousel: MVCarouselCollectionView, didScrollToCellAtIndex cellIndex : NSInteger) {

        // Page changed, can use this to update page control
    }
}
```

Configuration
-------------------------------------------------------
MVCarouselCollectionView was designed to be used with paging enabled. Please ensure the following properties are set:
* Paging Enabled = true
* Min spacing between cells = 0
* Min spacing between lines = 0

Requirements
-------------------------------------------------------
- MVCarouselCollectionView is compatible with Swift 1.2 and was tested under XCode 6.x. 
- iOS 8.0 or greater is supported.


License
-------------------------------------------------------
Copyright (c) 2015 Andrea Bizzotto bizz84@gmail.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
