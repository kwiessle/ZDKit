Pod::Spec.new do |s|

# 1
s.platform = :ios, '10.0'
s.ios.deployment_target = '10.0'
s.name = "ZDTools"
s.summary = "Personal Pod but feel free to use it :)"
s.requires_arc = true

# 2
s.version = "0.1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Kiefer Wiessler" => "kwiessle@student.42.fr" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
 s.homepage = "https://github.com/kwiessle/ZDTools"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/kwiessle/ZDTools.git",
 :tag => "#{s.version}" }

# 7
s.framework = "UIKit"


# 8
s.source_files = "ZDTools/**/*.{swift}"

# 9
# s.resources = "ZDTools/*"

# 10
s.swift_version = "4.2"

end
