Pod::Spec.new do |s|
  s.name         = "HoangDSCocoaDemo"
  s.version      = "1.1.7"
  s.summary      = "Small test to test code sharing via cocoapods."
  s.description  = "This is some superl oco framework that was made by Hoang NX"
  s.homepage     = "https://github.com/hoangdshp123/HoangDSCocoaDemo"
  s.license      = "MIT"
  s.author       = { "Hoang" => "hoangphuongalhp96@gmail.com" }
  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/hoangdshp123/HoangDSCocoaDemo.git", :tag => "1.1.7" }
  s.source_files = "HoangDSCocoaDemo/**/*"
  s.resource_bundle = {'HoangDSCocoaDemo' => ['HoangDSCocoaDemo/AssetLogin.xcassets/*']}
  s.swift_version = '5.0'
  s.ios.deployment_target  = '9.0'
  s.dependency 'KRProgressHUD'
  s.dependency 'Alamofire'
  s.dependency 'SwiftyJSON'
end
