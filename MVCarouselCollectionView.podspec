Pod::Spec.new do |s|
  s.name         = "MVCarouselCollectionView"
  s.version      = "1.0.0"
  s.summary      = "UICollectionView-based image carousel written in Swift"

  s.homepage     = "https://github.com/bizz84/MVCarouselCollectionView"

  s.license      = { :type => 'MIT', :file => 'LICENSE.md' }

  s.author       = { "Andrea Bizzotto" => "bizz84@gmail.com" }

  s.platform     = :ios, '8.0'

  s.source       = { :git => "https://github.com/bizz84/MVCarouselCollectionView.git", :tag => '1.0.0' }

  s.source_files = 'MVCarouselCollectionView/*.*'

  s.frameworks = 'UIKit', 'Foundation', 'CoreGraphics'

  s.requires_arc = true

end
