#
#  Be sure to run `pod spec lint MSVestBag.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
s.name         = "MS13OneStopHUD"
s.version      = "2.2.0"
s.license      =  { :type => 'MIT', :file => 'LICENSE' }
s.author       = { "gavin" => "lovegavin@outlook.com" }
s.homepage     = "https://github.com/GavinZw"
s.summary      = "This is a waistcoat bag ."

s.source_files  = 'src'
s.resources     = "src/Resources/vestimage.bundle"
s.ios.vendored_frameworks = 'src/*.framework'
s.source        = { :git => 'https://github.com/GavinZw/MS13OneStopHUD.git', :tag => s.version }

s.frameworks    = 'Foundation', 'UIKit'
s.dependency  'JPush', '~> 3.0.7'

s.requires_arc  = true
s.ios.deployment_target = '8.0'

end
