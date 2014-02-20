Pod::Spec.new do |s|
  s.name     = 'AMPPreviewController'
  s.version  = '0.1'
  s.license  = 'MIT'
  s.summary  = 'AMPPreviewController is a subclass of QLPreviewController that allows remote URL'
  #s.homepage = 'https://github.com/alexito4/UIKit-AMPAdditions'
  s.authors  = {
  	'Alejandro Martinez' => 'alexito4@gmail.com'
  }
  s.source   = { 
  	:git => 'https://github.com/alexito4/AMPPreviewController.git'
  }
  
  s.dependency 'AFNetworking', '~> 2.1.0'

  s.platform = :ios
  s.source_files = '*.{h,m}'
  s.requires_arc = true
  s.ios.deployment_target = '7.0'

  s.framework = 'UIKit', 'QuickLook'
end