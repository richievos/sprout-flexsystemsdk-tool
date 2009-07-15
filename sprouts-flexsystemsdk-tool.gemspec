Gem::Specification.new do |s|
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