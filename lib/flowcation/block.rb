module Flowcation
  class Block
    attr_reader :name, :type, :xpath
    def initialize(name, options={})
      @name, @type, @xpath = name, (options['substitute']||'content'), options['xpath']
    end
  end
end