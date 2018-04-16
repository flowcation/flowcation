require File.expand_path("./lib/flowcation.rb")

config_file = File.new('./test/integration/config/mockup.yml')
config = YAML.load config_file.read

Flowcation::generate config
