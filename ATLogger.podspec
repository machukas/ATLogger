#
#  Be sure to run `pod spec lint ATParse.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "ATLogger"
  s.version      = "1.0.1"
  s.summary      = "Simple logging library."
  s.description  = "This library makes it easy to log, with severity levels"
  s.homepage     = "http://EXAMPLE/ATParse"
  s.license      = "MIT"
  s.author             = { "machukas" => "machukkas@gmail.com" }


  s.platform     = :ios
  s.ios.deployment_target = '9.0'
  s.xcconfig = { 'SWIFT_VERSION' => '4.0' }

  s.source       = { :git => 'https://github.com/machukas/ATLogger.git' }

  s.source_files  = "ATLogger/**/*.{h,m,swift}"

end
