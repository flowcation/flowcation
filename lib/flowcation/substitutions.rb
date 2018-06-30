module Flowcation
  module Substitutions
    def substitute(doc)
      @substitutions&.each do |name, settings|
        if settings # might be disabled by defining empty substitution, what results in nil settings 
          substitution = Substitution.new \
            name, 
            settings['xpath'], 
            settings['substitute'], 
            settings['value'], 
            settings['key'],
            settings['helper']
          
          substitution.apply(doc)
        end
      end
    end
  end
end