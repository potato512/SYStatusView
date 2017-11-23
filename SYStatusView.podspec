  Pod::Spec.new do |s|

  s.name                = "SYStatusView"
  s.version             = "1.2.0"
  s.summary             = "SYStatusView is using for the status of the view, just like loading, or loaded success, or loaded fauiled, etc."
  s.homepage            = "https://github.com/potato512/SYStatusView"
  s.license             = { :type => "MIT", :file => "LICENSE" }
  s.author              = { "herman" => "zhangsy757@163.com" }
  s.platform            = :ios, "8.0"
  s.source              = { :git => "https://github.com/potato512/SYStatusView.git", :tag => s.version.to_s }
  s.source_files        = "SYStatusView/*.{h}", "SYStatusView/*.{h,m}"
  s.public_header_files = "SYStatusView/*.{h}"
  s.requires_arc        = true

  s.frameworks = 'UIKit'
