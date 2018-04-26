module Flowcation
  class Template
    include Substitutions, Registry
    register :blocks, type: :list
    attr_reader :path, :layout_name
    def initialize(doc, layout, path, content_for_blocks, substitutions, format)
      @doc = doc
      @path = path
      @layout_name = layout
      @substitutions = substitutions
      @format = format
      content_for_blocks&.each do |name, options|
        register_block Flowcation::Block.new(name, options)
      end
    end
    
    def content
      doc = @doc.dup
      substitute(doc)
      erb = ""
      if !blocks.empty?
        blocks.each do |block|
          block_doc = doc.at_xpath(block.xpath)
          raise BlockNotFoundException.build(xpath: block.xpath, path: self.path) unless block_doc
          content = case block.type 
            when 'content'
              doc.at_xpath(block.xpath).inner_html
            when 'replace_collection'
              doc.xpath(block.xpath).to_html
          end
        
          erb << @format.
            sub("::name::", block.name).
            sub("::content::", content)
        end
      else
        erb = doc.to_html
      end
      Render.sanitize(erb)
    end
    
    def self.from_config(options={})
      new \
        Nokogiri::HTML(File.new(options['file'])).xpath("//html"), 
        options['layout'], 
        options['path'], 
        options['content_for'], 
        options['substitutions'], 
        options['format']
    end
  end
end