module Flowcation
  class Partial
    include Substitutions, Callbacks
    attr_reader :path
    def initialize(doc, path, substitutions)
      @doc = doc
      @path = path
      @substitutions = substitutions || []
    end
    
    def content
      doc = @doc.dup
      substitute(doc)
      Render.sanitize(doc.to_html(encoding: 'UTF-8'))
    end
    
    def self.from_config(options={})
      doc = Nokogiri::HTML(File.new(options['file'])).xpath("//body").xpath(options['xpath'])
      doc = doc[0].children if options['type'] == 'content'
      partial = Flowcation::Partial.new \
        doc,
        options['path'],
        options['substitutions']
    end
  end
end