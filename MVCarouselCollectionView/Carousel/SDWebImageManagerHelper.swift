//
//  SDWebImageManagerHelper.swift
//  MVCarouselCollectionView
//
//  Created by Andrea Bizzotto on 11/12/2014.
//  Copyright (c) 2014 Muse Visions. All rights reserved.
//

import UIKit


var imageWebURLLoader : (imagePath : NSString, completion: (imagePath: NSString, image: UIImage?) -> ()) -> () = { (imagePath : NSString, completion: (imagePath: NSString, image: UIImage?) -> ()) in
    
    var url = NSURL(string: imagePath)
    SDWebImageManager.sharedManager().downloadImageWithURL(url, options: nil, progress: nil, completed: { (image : UIImage?, error: NSError?, cacheType: SDImageCacheType, finished: Bool, imageURL: NSURL?) in
    
        completion(imagePath: imagePath, image: image)
    })
}
    
var imageLocalLoader : (imagePath : NSString, completion: (imagePath: NSString, image: UIImage?) -> ()) -> () = { (imagePath : NSString, completion: (imagePath: NSString, image: UIImage?) -> ()) in

    var image = UIImage(named:imagePath)
    completion(imagePath: imagePath, image: image)
}
