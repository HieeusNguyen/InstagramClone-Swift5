project 'InstagramClone-Swift5.xcodeproj'

platform :ios, '14.0'

target 'InstagramClone-Swift5' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for InstagramClone
  pod 'SDWebImage'
  pod "Appirater"
  pod 'FirebaseCore'
  pod 'FirebaseAuth'
  pod 'FirebaseDatabase'
  pod 'FirebaseAnalytics'
  pod 'FirebaseCrashlytics'
  pod 'FirebaseStorage'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "14.0"
    end
  end
end
