module Flowcation
  module Registry
    extend ActiveSupport::Concern
    
    included do
    end

    class_methods do
      def register(register, options={})
        list = options[:type] == :list
        #registrator = options[:in] || :instance
        data = ActiveSupport::Inflector.singularize(register)
        define_method("register_#{data}") do |obj, v=nil|
          v ? send(register)[obj] = v : send(register) << obj
        end
        define_method(register) do
          instance_variable_set "@#{register}", (list ? [] : {}) unless instance_variable_get "@#{register}"
          instance_variable_get "@#{register}"
        end
      end
    end
  end
end