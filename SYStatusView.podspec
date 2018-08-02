Pod::Spec.new do |s|
  s.name         = "SYStatusView"
  s.version      = "1.2.1"
  s.summary      = "SYStatusView used to show status UI, such as start to request, finishing request, or failed to request."
  s.homepage     = "https://github.com/potato512/SYStatusView"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "herman" => "zhangsy757@163.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/potato512/SYStatusView.git", :tag => "#{s.version}" }
  s.source_files  = "SYStatusView/*.{h,m}"
  s.frameworks = "UIKit", "Foundation"
  s.requires_arc = true
end