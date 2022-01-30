platform :ios, '8.0'
use_frameworks!
target 'ios_youtube' do
    pod 'GoogleAPIClientForREST/YouTube'
    pod 'Google/SignIn'
    pod 'Firebase'
end

post_install do |installer|
    # add this post install script -- start
    installer.pods_project.build_configurations.each do |config|
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
end
