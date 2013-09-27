Pod::Spec.new do |s|

  s.name         = "AUStreamJSONMapper"
  s.version      = "0.0.1"
  s.summary      = "Deserialize JSON objects using streaming parser"
  s.homepage     = "https://github.com/appunite/AUStreamJSONMapper"
  s.author       = { "emil.wojtaszek" => "emil.wojtaszek@gmail.com" }
  s.source       = { :git => "https://github.com/appunite/AUStreamJSONMapper.git", :tag => "0.0.1" }
  s.license      = { :type => 'Apache License, Version 2.0', :file => 'LICENSE' }

  # Platform setup
  s.requires_arc = true
  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'
  
  s.source_files   = 'Classes/JSON.h', 'Classes/JSON/*.{h,m}', 'Classes/ObjectMapping.h', 'Classes/ObjectMapping/*.{h,m}'
  s.dependency       'SBJson'
  s.dependency       'RKValueTransformers', '~> 1.0.0'
  s.dependency       'ISO8601DateFormatterValueTransformer', '~> 0.5.0'

  ### Subspecs
      
  s.subspec 'CoreData' do |cdos|
    cdos.source_files = 'Classes/CoreData.h', 'Classes/CoreData/*.{h,m}'
    cdos.frameworks   = 'CoreData'
    cdos.dependency     'RKValueTransformers', '~> 1.0.0'
    cdos.dependency     'ISO8601DateFormatterValueTransformer', '~> 0.5.0'
  end
end
