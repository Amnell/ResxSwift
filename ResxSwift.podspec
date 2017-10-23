Pod::Spec.new do |s|
  s.name             = 'ResxSwift'
  s.version          = '0.1.1'
  s.summary          = 'ResxSwift makes it easy for you to use resx language resources to use for
  localization in your applications.'

  s.description      = <<-DESC
ResxSwift makes it easy for you to use resx language resources to use for
localization in your applications. Support for multiple resx namespaces and
language. Also ability to set default fallback language and resx namespace.
                       DESC

  s.homepage         = 'https://github.com/amnell/ResxSwift'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'amnell' => 'mathias@apping.se' }
  s.source           = { :git => 'https://github.com/amnell/ResxSwift.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/amnell'

  s.ios.deployment_target = '9.0'

  s.source_files = 'ResxSwift/Classes/**/*'

  s.dependency 'SWXMLHash', '~> 4.2.1'
end
