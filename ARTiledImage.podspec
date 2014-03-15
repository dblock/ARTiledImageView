Pod::Spec.new do |s|
  s.name             = "ARTiledImage"
  s.version          = "0.1.0"
  s.summary          = "An image tiling library."
  s.description      = "Display, pan and deep zoom with tiled images."
  s.homepage         = "https://github.com/dblock/ARTiledImage"
  s.screenshots      = "https://raw.github.com/dblock/ARTiledImage/Demo/Screenshots/ArmoryShow.png"
  s.license          = "MIT"
  s.author           = { "dblock" => "dblock@dblock.org", "orta" => "orta.therox@gmail.com" }
  s.source           = { :git => "https://github.com/dblock/ARTiledImage.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/dblockdotorg'
  s.platform         = :ios, '5.0'
  s.requires_arc     = true
  s.source_files     = 'Classes'
end
