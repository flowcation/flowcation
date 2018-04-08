module Flowcation
  class Layout
    include Substitutions, Registry
    register :blocks, type: :list
    attr_reader :path
    def initialize(doc, path, blocks, substitutions, format)
      @doc = doc
      @path = path
      @format = format
      @substitutions = substitutions
      blocks.each do |name, options|
        register_block Flowcation::Block.new(name, options)
      end
    end
  
    def content
      doc = @doc.dup
      substitute(doc)
      blocks.each do |block|
        block_doc = doc.at_xpath(block.xpath)
        raise BlockNotFoundException.build(xpath: block.xpath, path: self.path) unless block_doc
        value = @format.sub("::name::", block.name)
        case block.type
        when 'content'
          doc.at_xpath(block.xpath).content = value
        when 'replace'
          doc.at_xpath(block.xpath).replace Nokogiri::XML::Text.new(value, doc.document)
        when 'replace_collection'
          doc.at_xpath(block.xpath).replace Nokogiri::XML::Text.new(value, doc.document)
          doc.xpath(block.xpath).each do |node|
            node.remove if node.is_a? Nokogiri::XML::Element
          end
        end
      end
      Render.sanitize(doc.to_html(encoding: 'UTF-8'))
    end
    
    def self.from_config(options={})
      new \
        Nokogiri::HTML(File.new(options['file'])).xpath("/html"), 
        options['path'], 
        options['yields'], 
        options['substitutions'], 
        options['format']
    end
  end
end