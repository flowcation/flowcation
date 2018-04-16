require File.expand_path("./lib/flowcation.rb")

config_file = File.new('./test/integration/config/rails.yml')
config = YAML.load config_file.read

Flowcation::set_user_object name: 'processor', 
  config: config, 
  path: './test/integration/config'

Flowcation::generate config

Flowcation::Runtime.instance.write_files
