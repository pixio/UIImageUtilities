Pod::Spec.new do |s|
  s.name             = "UIImageUtilities"
  s.version          = "0.1.3"
  s.summary          = "A collection of useful image utility classes."
  s.description      = <<-DESC
A collection of useful image categories including:
* tinting (manual)
* rounded corners
* blur
* fix orientation so it's not broken (a.k.a. apple-style)
* resizing
                       DESC
  s.homepage         = "https://github.com/pixio/UIImageUtilities"
  s.license          = 'MIT'
  s.author           = { "Daniel Blakemore" => "DanBlakemore@gmail.com" }
  s.source = {
    :git => "https://github.com/pixio/UIImageUtilities.git",
    :tag => s.version.to_s
  }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = '*.{h,m}'

  s.public_header_files = '*.h'
  s.frameworks = 'UIKit', 'Accelerate'
end
