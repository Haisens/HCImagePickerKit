#
# Be sure to run `pod lib lint HCImagePickerMoudle.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HCImagePickerMoudle'
  s.version          = '0.0.1'
  s.summary          = '简单易用的图片选择器.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
图片选择器，选择本地相册图片.支持多张图片选择，工具栏UI自定义..
                       DESC

  s.homepage         = 'https://github.com/Haisens/HCImagePickerMoudle'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'haisens@163.com' => 'yinhaichao' }
  s.source           = { :git => 'https://github.com/Haisens/HCImagePickerMoudle.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

s.source_files = 'HCImagePickerMoudle/Classes/**/*.{h,m}'
  
  # s.resource_bundles = {
  #   'HCImagePickerMoudle' => ['HCImagePickerMoudle/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
