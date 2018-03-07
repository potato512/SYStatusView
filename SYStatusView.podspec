  Pod::Spec.new do |s|

  s.name         = "SYStatusView"   #名称
  s.version      = "1.2.0"          #版本号
  s.summary      = "有大量的类别和UI组件方便构建工程"  #描述
  s.homepage     = "https://github.com/potato512/SYStatusView" #描述页面
  s.license      = 'MIT'    #版权声明
  s.author       = { "herman" => "zhangsy757@163.com" }  #作者
  s.platform     = :ios, '5.0'    #支持的系统
  s.source       = { :git => "https://github.com/potato512/SYStatusView.git", :tag => "1.2.0" }   #源码地址
  s.source_files  = 'SYStatusView/*.{h,m}'    #源码
  s.requires_arc = true       #是否需要arc

  s.frameworks = 'UIKit'

  end
