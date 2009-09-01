sprout-flexsystemsdk-tool
=============
This is a sprout tool for using the flex sdk on your system to do your compiling. This has a couple benefits:

* You don't have to download another copy of the flex sdk if you already have it
* As long as you have the data visualization libraries in your sdk, it will automatically make them available

Example Rakefile
========
    require 'sprout'
    sprout 'as3'

    # enable github as a source
    Sprout::Sprout.gem_sources += ['http://gems.github.com']

    Sprout::Sprout.class_eval do
      # overriding this to allow sprout to be anywhere in the name, supporting github style aliases
      def self.sprout_to_gem_name(name)
        if(!name.match(/sprout-/))
          name = "sprout-#{name}-bundle"
        end
        return name
      end
    end

    mxmlc 'app.swf' do |t|
      # configure your build
      # ...
  
      # tell it to use our custom builder
      t.gem_name = 'jerryvos-sprout-flexsystemsdk-tool'
    end

Example Rakefile paired with [sprouts-extensions](http://github.com/jerryvos/sprouts-extensions)
========
    require 'sprout'
    sprout 'as3'

    # Performs all the 'setup to connect to github' work
    require 'sprouts-extensions'
    
    mxmlc 'app.swf' do |t|
      # configure your build
      # ...
  
      # tell it to use our custom builder
      t.gem_name = 'jerryvos-sprout-flexsystemsdk-tool'
    end
