platform :ios, '9.0'

target 'zyq' do
  use_frameworks!

  pod 'SwiftLint', '~> 0.27'
  pod 'SwiftyJSON', '~> 4.0'
  pod 'VIMediaCache'
  pod 'Firebase/Crashlytics'
  # Recommended: Add the Firebase pod for Google Analytics
  pod 'Firebase/Analytics'

target 'zyqTests' do
    inherit! :search_paths
end

end

# Workaround for Cocoapods issue #7606
post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end
