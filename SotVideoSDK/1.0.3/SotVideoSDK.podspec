require 'fileutils'

framework_target_name="SotVideoSDK"
framework_file_name="VideoSDK"
pod_package_name=framework_target_name

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.name         = "#{pod_package_name}"
  spec.version      = "1.0.3"
  spec.summary      = "Video SDK"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  spec.description  = <<-DESC
  Video SDK.
                   DESC

  spec.homepage     = "https://ios.sot.app"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.license      = { :type => "GPL", :file => "LICENSE.md" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.author             = { "bevvvis" => "bevis@sot.app" }
  
  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.platform     = :ios, "12.0"
  # spec.source       = { :http =>  'file://' + __dir__ + "/build/VideoSDK.1.0.0.zip"}
  spec.source       = { :http => "https://s3-ap-northeast-1.amazonaws.com/web.sot.app/VideoSDK.1.0.3.zip"}

  framework_path_hash = Hash.new
  framework_path_hash = { 
    :debug => "Products/Debug/#{framework_file_name}.framework",
    :release => "Products/Release/#{framework_file_name}.framework",
  }
  framework_path = framework_path_hash[:debug]
  framework_path_another = framework_path_hash[:release]

  use_release = ENV['use_release']
  if use_release != nil
    puts "[Info] #{pod_package_name}: force clean cache"
    system("pod cache clean '#{pod_package_name}' --all")
  end
  
  puts "#{use_release}"=="1"
  if "#{use_release}"!="0"
    puts "[Info] #{pod_package_name}: Using release frameworks"
    framework_path = framework_path_hash[:release]
    framework_path_another = framework_path_hash[:debug]
  else
    puts "[Info] #{pod_package_name}: Using debug frameworks"
    framework_path = framework_path_hash[:debug]
    framework_path_another = framework_path_hash[:release]
  end

  puts "[Info] #{pod_package_name} framework_path: #{framework_path}"

  #需要包含的源文件
  spec.source_files = "#{framework_path}/Headers/*.{h}"
  #你的SDK路径
  spec.vendored_frameworks = framework_path
  #SDK头文件路径
  spec.public_header_files = "#{framework_path}/Headers/*.{h}"

  spec.pod_target_xcconfig = {
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }
  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end
