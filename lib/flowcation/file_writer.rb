module Flowcation
  module FileWriter
    extend ActiveSupport::Concern
    
    included do
    end

    class_methods do
      def file_writer_collections
        @file_writer_collections
      end
      def writeables(file_writer_collections)
        @file_writer_collections = file_writer_collections
      end
    end
    
    def write_files
      # todo rescue/finally close file
      self.class.file_writer_collections.each do |writables|
        send(writables).each do |writeable|
          file_name = writeable.path
          path = File.dirname file_name
          FileUtils.mkdir_p(path)
          if check_if_generated_by_flowcation! file_name
            file = File.new(file_name, 'w')
            c = writeable.content
            c = add_generated_comment c
            File.write(file, c.encode(cr_newline: true))
          else
            STDERR.puts "File #{file_name} not generated by flowcation. Use -f to overwrite or add Setting 'force-overwrite: true' to configuration yaml file entry 'flowcation:'"
          end
        end
      end
    end
    
    def within_comment(content)
      comment = Settings.get('comment') || DEFAULT_COMMENT
      comment.sub("::comment::", content)
    end
    
    def generated_comment
      Settings.get('generated-line') || DEFAULT_GENERATED_TEXT
    end
    
    def add_generated_comment(content)
      within_comment(generated_comment) + "\n" + content
    end
    
    def generated?(file)
      !!File.open(file).readlines.first&.scan(/#{generated_comment}/)&.send(:[],0)
    end
    
    def check_if_generated_by_flowcation!(file)
      return true unless File.exist? file
      return true if Settings.get('force-overwrite')
      generated? file
      # if generated? file
      #   return true
      # else
      #   raise OverwriteException.for_file(file)
      # end
    end
  end
end