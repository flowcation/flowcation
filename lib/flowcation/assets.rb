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
        
        if processor = Settings.get('processor_object')
          options['post-process']&.each do |asset_path, file_process|
            asset_folder_path = File.join(options['output'], asset_path)
            file_process.each do |file_name, process_method|
              #file = File.new(File.join(asset_folder_path, file_name))
              path = File.join(asset_folder_path, file_name)
              puts "Post Process #{File.join(asset_folder_path, file_name)}"
              lines = IO.readlines(path).map do |line|
                processor.send(process_method, line)
              end
              File.open(path, 'w') do |file|
                file.puts lines
              end
            end
          end
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