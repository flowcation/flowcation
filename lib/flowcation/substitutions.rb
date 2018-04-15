module Flowcation
  module Substitutions
    def substitute(doc)
      @substitutions&.each do |name, settings|
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