Pod::Spec.new do |s|
  s.name             = 'StyledText'
  s.version          = '1.2.0'
  s.summary          = 'Declarative text styles and simple Dynamic Type support for iOS'
  s.description      = <<-DESC
                        StyledText is a library that simplifies styling dynamic text in iOS applications. Instead of having to use attributed strings every time you need to update text, you can declaratively set a text style on your labels. When the text of the label is updated, the label uses the preset style.
                       DESC
  s.homepage         = 'https://github.com/blueapron/styled-text'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'huebnerob' => 'robert.huebner@blueapron.com' }
  s.source           = { :git => 'https://github.com/blueapron/styled-text.git', :tag => 'v' + s.version.to_s }
  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'
  s.source_files = 'StyledText/Classes/**/*'
  s.frameworks = 'UIKit'
end
