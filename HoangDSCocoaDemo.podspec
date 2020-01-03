Pod::Spec.new do |s|
  s.name         = "HoangDSCocoaDemo"
  s.version      = "1.0.6"
  s.summary      = "Small test to test code sharing via cocoapods."
  s.description  = "This is some superl oco framework that was made by kevin vugts."
  s.homepage     = "https://github.com/hoangdshp123/HoangDSCocoaDemo"
  s.license      = "MIT"
  s.author       = { "Hoang" => "hoangphuongalhp96@gmail.com" }
  s.platform     = :ios, "11.0"
  s.source       = { :git => "https://github.com/hoangdshp123/HoangDSCocoaDemo.git", :tag => "1.0.6" }
  s.source_files = "HoangDSCocoaDemo/**/*"
  s.exclude_files = "HoangDSCocoaDemo/**/*.plist"
  s.swift_version = '5.0'
  s.ios.deployment_target  = '11.0'
end
