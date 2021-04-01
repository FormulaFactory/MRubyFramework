#
# Be sure to run `pod lib lint MRubyFramework.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MRubyFramework'
  s.version          = '2.1.2.1'
  s.summary          = 'MRuby for iOS'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  MRuby Framework for iOS;
                       DESC

  s.homepage         = 'https://github.com/tailang/MRubyFramework'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ping.cao' => 'caopingcpu@163.com' }
  s.source           = { :git => 'https://github.com/tailang/MRubyFramework.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'MRubyFramework/Classes/**/*'

  s.ios.deployment_target = '9.0'
  s.vendored_frameworks = 'ios/MRuby.framework'
  s.libraries = 'c++'
  s.frameworks = 'Foundation'

  s.user_target_xcconfig = { 'CLANG_ALLOW_NON_MODULAR_INCLUDES_IN_FRAMEWORK_MODULES' => 'YES' }
  
  # s.resource_bundles = {
  #   'MRubyFramework' => ['MRubyFramework/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
