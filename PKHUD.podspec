Pod::Spec.new do |s|
  s.name                      = 'PKHUD'
  s.module_name               = 'PKHUD'
  s.version                   = '3.1.07'
  s.summary                   = 'A Swift based reimplementation of the Apple HUD (Volume, Ringer, Rotation,…) for iOS 8 and up and OSX 10.11 and up'
  s.homepage                  = 'https://github.com/pkluz/PKHUD'
  s.license                   = 'MIT'
  s.author                    = { 
	  'Philip Kluz' => 'Philip.Kluz@gmail.com',
	  'Fabian Renner' => 'fabian@outbank.io'
  }
  s.ios.deployment_target     = '8.0'
  s.osx.deployment_target     = '10.11'
  s.requires_arc              = true
  s.source                    = { :git => 'https://github.com/teamoutbank/PKHUD.git', :tag => s.version.to_s }
  s.source_files              = 'Shared/**/*.{h,swift}'
  s.osx.source_files          = 'PKHUDMACOS/**/*.{h,swift}'
  s.ios.source_files          = 'PKHUD/**/*.{h,swift}'
  s.resources                 = 'Shared/*.xcassets'
end
