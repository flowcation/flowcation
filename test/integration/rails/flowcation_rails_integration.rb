require File.expand_path("./lib/flowcation.rb")

config_file = File.new('./test/integration/rails/rails.yml')
config = YAML.load config_file.read

Flowcation::generate config

# Todo Ask for Permission for writing files. y/n/A
Flowcation::Runtime.instance.write_files
