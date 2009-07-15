# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{sprout-flexsystemsdk-tool}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Adobe, Inc."]
  s.date = %q{2009-07-14}
  s.description = %q{A sprout tool for interacting with your local sdk}
  s.email = %q{jerry.vos@gmail.com}
  s.executables = ["adl", "adt", "asdoc", "compc", "fdb", "mxmlc"]
  s.files = [
    "VERSION",
     "bin/adl",
     "bin/adt",
     "bin/asdoc",
     "bin/compc",
     "bin/fdb",
     "bin/mxmlc",
     "rakefile.rb",
     "sprout.spec",
     "sprouts-flexsystemsdk-tool.gemspec"
  ]
  s.homepage = %q{http://github.com/jerryvos/sprouts-flexsystemsdk-tool}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{Adobe Flex 3 SDK including mxmlc, compc, asdoc and fdb}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sprout>, [">= 0.7.1"])
    else
      s.add_dependency(%q<sprout>, [">= 0.7.1"])
    end
  else
    s.add_dependency(%q<sprout>, [">= 0.7.1"])
  end
end
