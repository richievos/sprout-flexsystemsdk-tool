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

spec = Gem::Specification.new do |s|
  s.platform            = Gem::Platform::RUBY
  s.summary             = SUMMARY
  s.description         = DESCRIPTION
  s.name                = NAME
  s.version             = GEM_VERSION
  s.author              = AUTHOR
  s.email               = EMAIL
  s.homepage            = HOMEPAGE
  # s.rubyforge_project   = PROJECT
  s.require_path        = 'lib'
  s.bindir              = 'bin'
  s.has_rdoc            = false
  s.files               = PKG_LIST.to_a
  s.executables         = []
  s.default_executable  = ''

  s.add_dependency('sprout', '>= 0.7.1')
end

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