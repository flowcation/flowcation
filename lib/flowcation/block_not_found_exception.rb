module Flowcation
  class BlockNotFoundException < Exception
    def self.build(xpath:, path:)
      new("Yield Block #{xpath} not found for Layout #{path}")
    end
  end
end