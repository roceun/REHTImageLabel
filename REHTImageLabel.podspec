#
# Be sure to run `pod lib lint REHTImageLabel.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'REHTImageLabel'
  s.version          = '0.4.0'
  s.summary          = 'Label with head/tail imageview.'
  s.homepage         = 'https://github.com/roceun/REHTImageLabel'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'roceun' => 'roceun@gmail.com' }
  s.source           = { :git => 'https://github.com/roceun/REHTImageLabel.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'REHTImageLabel/Classes/**/*'
end
