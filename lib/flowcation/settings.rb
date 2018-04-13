require "singleton"
module Flowcation
  class Settings
    include Registry, Singleton
    register :settings
    
    def self.get(k)
      instance.settings[k]
    end
    
    def self.set(k, v)
      instance.settings[k] = v
    end
    
    def self.from_config(options={})
      options&.each do |k,v|
        instance.register_setting k,v
      end
    end
  end
end