module Flowcation
  class SubstitutionNotFoundException < Exception
    def self.build(xpath:, name:)
      new("Substitution #{name} not found for xpath #{xpath}")
    end
  end
end