require 'jeweler'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = 'sprout-flexsystemsdk-tool'
    gemspec.summary = "A sprout tool for interacting with your local sdk"
    gemspec.email = 'jerry.vos@gmail.com'
    gemspec.homepage = 'http://github.com/jerryvos/sprout-flexsystemsdk-tool'
    gemspec.add_dependency('sprout', '>= 0.7.1')

    gemspec.platform            = Gem::Platform::RUBY
    gemspec.has_rdoc            = false
    gemspec.executables         = []
    # s.default_executable  = ''
  end
rescue LoadError
  puts "Jeweler not available. Install it with: sudo gem install technicalpickles-jeweler -s http://gems.github.com"
end

BIN_PKG_NAME = File.join('pkg', 'unix_command_aliases.tar.gz')

namespace :bin do
  task :generate do
    %w(adl adt asdoc compc fdb mxmlc).each do |command|
      File.open(File.join(File.dirname(__FILE__), 'bin', command), 'w') do |file|
        file.write <<-EOF
#!/usr/bin/env ruby
# Append $FLEX_SDK/bin to the PATH if it isn't already
if ENV['FLEX_SDK']
  path_separator = RUBY_PLATFORM =~ /(mingw)|win/ ? ";" : ":"

  flex_sdk_bin = File.join(ENV['FLEX_SDK'], bin)

  ENV['PATH'] += "#{path_separator}#{flex_sdk_bin}" unless ENV['PATH'].include?(flex_sdk_bin)
end
exec("#{command}", *ARGV)
EOF
      end
    end
  end

  task :package => :generate do
    system "tar -czf #{BIN_PKG_NAME} bin"
  end
end

desc "Reinstall this gem"
task :reinstall do |t|
  system "sudo gem uninstall #{NAME}"
  system "rake clean package"
  system "sudo gem install -f pkg/#{NAME}-#{GEM_VERSION}.gem"
end