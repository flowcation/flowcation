#require 'rails/generators'
require 'rails/generators'
require 'rails/generators/base'
module Flowcation
  module Generate
    class ConfigGenerator < Rails::Generators::Base
      desc "This generator creates a basic rails.yml file at config/flowcation"
      source_root File.expand_path("../templates", __FILE__)
      def copy_config_file
        copy_file "rails.yml", "config/flowcation/rails.yml"
        copy_file "public.yml", "config/flowcation/public.yml"
      end
    end
  end
end