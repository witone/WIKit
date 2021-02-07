#
# Be sure to run `pod lib lint WIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WIKit'
  s.version          = '0.1.5'
  s.summary          = '拓展基础控件，提高开发效率'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: 拓展基础控件，提高开发效率.
                       DESC

  s.homepage         = 'https://github.com/wikit-zyp/WIKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zyp' => 'me_zyp@163.com' }
  s.source           = { :git => 'https://github.com/wikit-zyp/WIKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.public_header_files = 'WIKit/*.h'
  s.source_files = 'WIKit/WIKit.h'
  
  s.subspec 'WICore' do |ss|
      ss.source_files = 'WIKit/Base/**/*'
  end
  
  s.subspec 'Utility' do |ss|
      ss.source_files = 'WIKit/Utility/**/*'
  end
  
  #s.subspec 'WIUI' do |ss|
  #    ss.source_files = 'WIKit/WIUI/**/*'
  #    ss.dependency 'WIKit/WICore'
  #end
  
  # s.resource_bundles = {
  #   'WIKit' => ['WIKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
