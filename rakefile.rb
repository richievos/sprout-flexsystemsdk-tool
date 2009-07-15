require 'rake'
require 'rake/gempackagetask'
require 'rake/clean'
require 'rake/testtask'
require 'lib/sprout/flexsystemsdk/version'

# http://cloud.github.com/downloads/jerryvos/project-sprouts/unix_command_aliases.tar.gz
# PROJECT                 = 'sprout'
NAME                    = 'sprout-flexsystemsdk-tool'
SUMMARY                 = 'Adobe Flex 3 SDK including mxmlc, compc, asdoc and fdb'
GEM_VERSION             = Sprout::FlexSystemSDK::VERSION::STRING
AUTHOR                  = 'Adobe, Inc.'
EMAIL                   = 'projectsprouts@googlegroups.com'
HOMEPAGE                = 'http://github.com/jerryvos/sprouts-flexsystemsdk-tool'
DESCRIPTION             = "A sprout tool for interacting with your local sdk"
HOMEPATH                = "http://github.com/jerryvos/sprouts-flexsystemsdk-tool"
RELEASE_TYPES           = ["gem"]
PKG_LIST                = FileList['[a-zA-Z]*',
                                  'bin/**/*',
                                  'lib/**/*'
                                  ]

BIN_PKG_NAME = File.join('pkg', 'unix_command_aliases.tar.gz')

PKG_LIST.exclude('.svn')
PKG_LIST.exclude('artifacts')
PKG_LIST.each do |file|
  task :package => file
end

spec = eval(File.read('sprouts-flexsystemsdk-tool.gemspec'))

Rake::GemPackageTask.new(spec) do |p|
end

namespace :bin do
  task :generate do
    %w(adl adt asdoc compc fdb mxmlc).each do |command|
      File.open(File.join(File.dirname(__FILE__), 'bin', command), 'w') do |file|
        file.write <<-EOF
#!/usr/bin/env ruby
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