module Flowcation
  class Assets
    
    def self.from_config(config={})
      config&.each do |name, options|
        options['folders']&.each do |path, asset_folder_name|
          asset_folder_path = File.join(options['output'], asset_folder_name)
          FileUtils.mkdir_p(asset_folder_path)
          asset_folder = File.new(asset_folder_path)
          copy_assets \
            source: File.join(options['input'], path), 
            target: asset_folder
        end
        options['single-files']&.each do |file_name|
          output_folder_path = File.join(options['output'])
          FileUtils.mkdir_p(output_folder_path)
          output_folder = File.new(output_folder_path)
          FileUtils.cp(File.join(options['input'], file_name), output_folder) 
        end
      end
    end
    
    def self.copy_assets(source:, target:)
      FileUtils.mkdir_p(target)
      Dir.entries(source).reject {|file_name| %w(. ..).include?(file_name) }.each do |file_name|
        if File.directory? File.join(source, file_name)
          copy_assets \
            source: File.join(source, file_name), 
            target: File.join(target, file_name)
        else
          FileUtils.cp(File.join(source, file_name), target) 
        end
      end
    end
  end
end