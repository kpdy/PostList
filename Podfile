# Uncomment the next line to define a global platform for your project
platform :ios, '15.0'

def shared_pods
  
  
  # Network abstraction layer written in Swift. - API Call
  # https://github.com/Moya/Moya
  pod 'Moya', '15.0.0'
  
end


target 'PostList' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for PostList
  shared_pods

end

post_install do |pi|
    pi.pods_project.targets.each do |t|
        t.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
            config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
        end
    end
end
