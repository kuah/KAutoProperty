Pod::Spec.new do |s|
  s.name         = 'KProperty'
  s.version      = '0.1'
  s.summary      = '一键懒加载'
  s.homepage     = 'https://github.com/kuah/KAutoProperty'
  s.author       = "CT4 => 284766710@qq.com"
  s.source       = {:git => 'https://github.com/kuah/KAutoProperty.git', :tag => "#{s.version}"}
  s.source_files = "source/**/*.{h,m}"
  s.requires_arc = true
  s.libraries = 'z'
  s.ios.deployment_target = '8.0'
  s.license = 'MIT'
  s.frameworks = 'UIKit'
  s.dependency 'YYModel', '~> 1.0.4'
  s.dependency 'KRunTime', '~> 0.1'
end
