Pod::Spec.new do |s|
  s.name             = 'SAFloatingTabbarController'
  s.version          = '0.1.0'
  s.summary          = 'Floating Tabbar with default Tabbar controller options'
 
  s.description      = <<-DESC
Floating Tabbar with default Tabbar controller options along with selection indicator
                       DESC
 
  s.homepage         = 'https://github.com/SarimAshfaq/FloatingTabbarController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Sarim Ashfaq' => 'sarimashfaq@gmail.com' }
  s.source           = { :git => 'https://github.com/SarimAshfaq/FloatingTabbarController.git', :tag => s.version.to_s }
 s.swift_version = '4.2'
  s.ios.deployment_target = '10.0'
  s.source_files = 'Floating Tabbar Controller/FloatingTabbarController.swift'
 
end