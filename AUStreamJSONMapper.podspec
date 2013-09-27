Pod::Spec.new do |s|

  s.name         = "AUStreamJSONMapper"
  s.version      = "0.0.1"
  s.summary      = "Deserialize JSON objects using streaming parser"
  s.homepage     = "https://github.com/appunite/AUStreamJSONMapper"
  s.author       = { "emil.wojtaszek" => "emil.wojtaszek@gmail.com" }
  s.source       = { :git => "https://github.com/appunite/AUStreamJSONMapper", :tag => "0.0.1" }
  s.license      = { :type => 'Apache License, Version 2.0', :file => 'LICENSE' }

  # Platform setup
  s.requires_arc = true
  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.7'
  
  # Exclude optional Search and Testing modules
  s.default_subspec = 'Core'

  ### Subspecs
  
  s.subspec 'Core' do |cs|    
    cs.dependency       'SBJson'
    cs.dependency       'AUStreamJSONMapper/ObjectMapping'
    cs.dependency       'AUStreamJSONMapper/CoreData'
    cs.dependency       'RKValueTransformers', '~> 1.0.0'
    cs.dependency       'ISO8601DateFormatterValueTransformer', '~> 0.5.0'
  end
  
  s.subspec 'ObjectMapping' do |os|
    os.source_files   = 'Classes/Core'
    os.dependency       'RKValueTransformers', '~> 1.0.0'
    os.dependency       'ISO8601DateFormatterValueTransformer', '~> 0.5.0'
  end
  
  s.subspec 'CoreData' do |cdos|
    cdos.source_files = 'Classes/CodeData'
    cdos.frameworks   = 'CoreData'
  end
end
