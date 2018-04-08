require "singleton"
module Flowcation
  class Runtime
    include Registry, Singleton, FileWriter
    register :layouts, type: :list
    register :templates, type: :list
    register :partials, type: :list
    writeables %i( layouts templates partials )
    
    def self.register_layouts_from_config(config={})
      config&.each do |name, options|
        instance.register_layout Layout.from_config(options)
      end
    end
    
    def self.register_templates_from_config(config={})
      config&.each do |name, options|
        instance.register_template Template.from_config(options)
      end
    end
    
    def self.register_partial_from_config(config={})
      config&.each do |name, options|
        instance.register_partial Partial.from_config(options)
      end
    end
  end
end