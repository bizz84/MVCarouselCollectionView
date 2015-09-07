Pod::Spec.new do |s|
  s.name         = 'MVCarouselCollectionView'
  s.version      = '1.0.5'
  s.summary      = 'UICollectionView-based image carousel written in Swift'
  s.license      = 'MIT'
  s.homepage     = 'https://github.com/bizz84/MVCarouselCollectionView'
  s.author       = { 'Andrea Bizzotto' => 'bizz84@gmail.com' }
  s.ios.deployment_target = '8.0'

  s.source       = { :git => "https://github.com/bizz84/MVCarouselCollectionView.git", :tag => s.version }

  s.source_files = 'MVCarouselCollectionView/*.{swift,xib}'

  s.screenshots  = ["https://github.com/bizz84/MVCarouselCollectionView/raw/master/screenshot.png"]

  s.requires_arc = true
end
