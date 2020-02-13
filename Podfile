# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'ZiheChat' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ZiheChat
  pod 'LeanCloud'
  pod 'BmobSDK'
  pod 'SVProgressHUD'
  pod 'ChameleonFramework'

  target 'ZiheChatTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ZiheChatUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CLANG_WARN_DOCUMENTATION_COMMENTS']='NO'
    end
  end
end
