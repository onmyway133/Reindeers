Pod::Spec.new do |s|
  s.name             = "Reindeers"
  s.summary          = "XML in Swift"
  s.version          = "2.1.0"
  s.homepage         = "https://github.com/onmyway133/Reindeers"
  s.license          = 'MIT'
  s.author           = { "Khoa Pham" => "onmyway133@gmail.com" }
  s.source           = {
    :git => "https://github.com/onmyway133/Reindeers.git",
    :tag => s.version.to_s
  }
  s.social_media_url = 'https://twitter.com/onmyway133'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.11'
  s.tvos.deployment_target = '10.0'

  s.requires_arc = true
  s.source_files = 'Sources/**/*'

  s.preserve_path = 'Cocoapods/*'
  s.xcconfig = {
    'HEADER_SEARCH_PATHS' => '$(SDKROOT)/usr/include/libxml2',
    'SWIFT_INCLUDE_PATHS' => '$(SRCROOT)/Reindeers/Cocoapods'
  }

  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.2' }
end
