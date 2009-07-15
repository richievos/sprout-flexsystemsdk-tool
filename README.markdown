sprout-flexsystemsdk-tool
=============

Example Rakefile
========
    require 'sprout'
    sprout 'as3'

    # enable github
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
