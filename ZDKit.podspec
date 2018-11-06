Pod::Spec.new do |s|
s.name             = 'ZDKit'
s.version          = '0.0.1'
s.summary          = 'ZDCrew Pod, feel free to use it :)'

s.description      = <<-DESC
This fantastic view changes its color gradually makes your app look fantastic!
DESC

s.homepage         = 'https://www.kieferwiessler.com/zdkit'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'Kiefer Wiessler' => 'kwiessle@student.fr' }
s.source           = { :git => 'https://github.com/kwiessle/ZDKits.git', :tag => s.version.to_s }
s.swift_version    = '4.2'

s.ios.deployment_target = '12.0'
s.source_files = 'ZDKit/*.swift'

end
