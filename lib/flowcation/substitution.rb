module Flowcation
  class Substitution
    attr_reader :name, :xpath, :type, :value
    def initialize(name, xpath, type, value, key)
      @name, @xpath, @type, @value, @key = name, xpath, type, value, key
    end
    def value(node)
      if helper = Settings.get('helper')
        helper.send(@value, node)
      else
        @value
      end
    end
    def apply(doc)
      # todo Refactor to SubstitutionType class with ContentSubstitution, AttributeSubstitution...
      
      # todo Better type names. More Like Targets in Stimulus? each->attribute
      #   Even Helpers could be included in type: each-replace->LayoutHelper#image_tag
      
      element = doc.at_xpath(@xpath)
      raise SubstitutionNotFoundException.build(xpath: @xpath, name: @name) unless element
      case @type
      when 'content'
        doc.at_xpath(@xpath).content = value(doc.at_xpath(@xpath))
      when 'content_collection'
        doc.xpath(@xpath).each do |node|
          node.content = value(node)
        end
      when 'attribute'
        doc.at_xpath(@xpath).attributes[@key].value = value(doc.at_xpath(@xpath))
      when 'attribute_collection'
        doc.xpath(@xpath).each do |node|
          node.attributes[@key].value = value(node)
        end
      when 'replace'
        doc.at_xpath(@xpath).replace Nokogiri::XML::Text.new(value(doc.at_xpath(@xpath)), doc.document)
      when 'replace_each'
        doc.xpath(@xpath).each do |node|
          node.replace Nokogiri::XML::Text.new(value(node), doc.document)
        end
      when 'replace_collection'
        doc.xpath(@xpath).first.replace Nokogiri::XML::Text.new(@value, doc.document)
        doc.xpath(@xpath).each do |node|
          node.remove if node.is_a? Nokogiri::XML::Element
        end
      when 'append'
        puts "APPEND #{doc.at_xpath(@xpath).class}"
        doc.at_xpath(@xpath).after Nokogiri::XML::Text.new(value(doc.at_xpath(@xpath)), doc.document)
      end
      doc
    end
  end
end