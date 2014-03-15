Pod::Spec.new do |s|
  s.name             = "ARTiledImageView"
  s.version          = "0.1.0"
  s.summary          = "An tiled image view."
  s.description      = "Display, pan and deep zoom with tiled images on iOS."
  s.homepage         = "https://github.com/dblock/ARTiledImageView"
  s.screenshots      = "https://raw.github.com/dblock/ARTiledImageView/Demo/Screenshots/ArmoryShow.png"
  s.license          = "MIT"
  s.author           = { "dblock" => "dblock@dblock.org", "orta" => "orta.therox@gmail.com" }
  s.source           = { :git => "https://github.com/dblock/ARTiledImage.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/dblockdotorg'
  s.platform         = :ios, '5.0'
  s.requires_arc     = true
  s.source_files     = 'Classes'
  s.frameworks       = 'Foundation', 'UIKit', 'CoreGraphics'
  s.dependencies     = ['SDWebImage']
end
