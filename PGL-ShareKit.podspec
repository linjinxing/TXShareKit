Pod::Spec.new do |s|
    s.name         = "PGL-ShareKit"
    s.version      = "0.0.34"
    s.summary      = "A short description of PGL-ShareKit."

    s.description  = <<-DESC
    A longer description of HSNKit in Markdown format.

    * Think: Why did you write this? What is the focus? What does it do?
    * CocoaPods will be using this to generate tags, and improve search results.
    * Try to keep it short, snappy and to the point.
    * Finally, don't worry about the indent, CocoaPods strips it!
    DESC

    s.homepage     = "http://EXAMPLE/HSNKit"

    s.license      = "Copyright"

    s.author       = { "ljx" => "linjinxing@camera360.com" }

    s.source       = { :git => "ssh://git@mobiledev.camera360.com:7999/pglib/pgl-sharekit.git", :tag => s.version.to_s}

    s.requires_arc = true

    s.ios.deployment_target = '7.0'

    s.source_files = 'Classes/**/*.{h,m,mm,cpp,c}'

    s.resources = "PGShareKit/PGL-ShareKit.bundle"

    s.dependency 'WeixinSDK'
    s.dependency 'QQSDK'
    s.dependency 'WeiboSDK'
    s.dependency 'ReactiveCocoa'
    s.dependency 'BoltsFramework'
    s.dependency 'MiniFBCore'
    s.dependency 'MiniFBLogin'
    s.dependency 'MiniFBShare'
    s.dependency 'HDevice/HSystem'
    s.dependency 'PGL-LocalizationHelper'
end



