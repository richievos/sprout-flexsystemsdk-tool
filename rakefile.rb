require 'jeweler'

# PROJECT                 = 'sprout'
NAME                    = 'sprout-flexsystemsdk-tool'
SUMMARY                 = 'Adobe Flex 3 SDK including mxmlc, compc, asdoc and fdb'
AUTHOR                  = 'Adobe, Inc.'
EMAIL                   = 'jerry.vos@gmail.com'
HOMEPAGE                = 'http://github.com/jerryvos/sprout-flexsystemsdk-tool'
DESCRIPTION             = "A sprout tool for interacting with your local sdk"
HOMEPATH                = "http://github.com/jerryvos/sprout-flexsystemsdk-tool"
RELEASE_TYPES           = ["gem"]
PKG_LIST                = FileList['[a-zA-Z]*',
                                  'bin/**/*',
                                  'lib/**/*'
                                  ]

PKG_LIST.exclude('.svn')
PKG_LIST.exclude('artifacts')
PKG_LIST.each do |file|
  task :package => file
end

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gemspec|
    gemspec.name = NAME
    gemspec.summary = SUMMARY
    gemspec.description = DESCRIPTION
    gemspec.email = EMAIL
    gemspec.homepage = HOMEPAGE
    gemspec.description = DESCRIPTION
    gemspec.authors = [AUTHOR]
    gemspec.files = PKG_LIST.to_a
    gemspec.add_dependency('sprout', '>= 0.7.1')

    gemspec.platform            = Gem::Platform::RUBY
    gemspec.has_rdoc            = false
    # s.summary             = SUMMARY
    # s.description         = DESCRIPTION
    # s.name                = NAME

    # s.version             = GEM_VERSION
    # s.require_path        = 'lib'
    # s.bindir              = 'bin'

    # s.author              = AUTHOR
    # s.email               = EMAIL
    # s.homepage            = HOMEPAGE
    # s.rubyforge_project   = PROJECT
    # s.files               = PKG_LIST.to_a
    # s.executables         = []
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