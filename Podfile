# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Money2020Product' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

    pod 'ARSLineProgress', '~> 2.0'
    pod 'PickerView'
    pod 'Fusuma', :git => 'https://github.com/Ferrick90/Fusuma.git', :commit => 'a8a00a7'
    pod 'Starscream', '~> 2.0'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
