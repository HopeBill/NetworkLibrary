Pod::Spec.new do |s|
s.name             = 'NetworkLibrary'
s.version          = '0.1.0'
s.summary          = '网络框架'

s.description      = '网络框架'

s.homepage         = 'https://github.com/LiBiYong/NetworkLibrary'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { '1255418023@qq.com' => '1255418023@qq.com' }
s.source           = { :git => 'https://github.com/LiBiYong/NetworkLibrary.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '8.0'

#s.source_files = 'NetworkLibrary/**/*'

#  s.resource_bundle= {
#     'AsstesImageBundle' => ['NetworkLibrary/*.png']
#  }

# s.public_header_files = 'Pod/Classes/**/*.h'
# s.frameworks = 'UIKit'
s.dependency 'AFNetworking',         '~>3.1.0'
end

