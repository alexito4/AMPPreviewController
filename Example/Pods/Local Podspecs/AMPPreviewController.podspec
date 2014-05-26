Pod::Spec.new do |s|

  s.name             = 'AMPPreviewController'
  s.version          = '0.1'
  s.summary          = 'AMPPreviewController is a subclass of QLPreviewController that allows remote URL'
  #s.description      = <<-DESC
  #                     A little class to use the Imageholder API in your Apps.
  #                     DESC
  s.homepage         = "https://github.com/alexito4/AMPPreviewController"
  #s.screenshots      = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Alejandro Martinez" => "alexito4@gmail.com" }
  s.source           = { :git => "https://github.com/alexito4/AMPPreviewController.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/alexito4'


  s.dependency 'AFNetworking', '~> 2.2'

  s.platform     = :ios, '7.0'
  # s.ios.deployment_target = '5.0'
  # s.osx.deployment_target = '10.7'
  s.requires_arc = true

  s.source_files = 'Classes'
  #s.resources = 'Assets

  s.ios.exclude_files = 'Classes/osx'
  s.osx.exclude_files = 'Classes/ios'
  s.public_header_files = 'Classes/**/*.h'
  s.framework = 'UIKit', 'QuickLook'
  # s.dependency 'JSONKit', '~> 1.4'
end
