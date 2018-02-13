# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'RSSFeedCleanSwift' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for RSSFeedCleanSwift
  pod 'SnapKit', '~> 4.0.0'
  pod 'Alamofire', '~> 4.5'
  pod 'SwiftyJSON', '~> 4.0.0'
  pod 'SDWebImage', '~> 4.0'

  target 'RSSFeedCleanSwiftTests' do
    inherit! :search_paths
    # Pods for testing
  end

  post_install do |installer|
    installer.pods_project.targets.each do |target|
        if target.name == '<insert target name of your pod here>'
            target.build_configurations.each do |config|
                config.build_settings['SWIFT_VERSION'] = '4.0'
            end
        end
    end
  end

end
