#require 'rails/generators'
require 'rails/generators'
require 'rails/generators/base'
module Flowcation
  module Generate
    class ConfigGenerator < Rails::Generators::Base
      desc "This generator creates a basic rails.yml file at config/flowcation"
      def copy_config_file
        copy_file "rails.yml", "config/flowcation/rails.yml"
      end
    end
  end
end