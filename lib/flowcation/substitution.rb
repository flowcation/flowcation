module Flowcation
  class Substitution
    attr_reader :name, :xpath, :type, :value
    def initialize(name, xpath, type, value, key)
      @name, @xpath, @type, @value, @key = name, xpath, type, value, key
    end
    def apply(doc)
      element = doc.at_xpath(@xpath)
      raise SubstitutionNotFoundException.build(xpath: @xpath, name: @name) unless element
      case @type
      when 'content'
        doc.at_xpath(@xpath).content = @value
      when 'attribute'
        doc.at_xpath(@xpath).attributes[@key].value = @value
      when 'replace'
        doc.at_xpath(@xpath).replace Nokogiri::XML::Text.new(@value, doc.document)
      when 'append'
        puts "APPEND #{doc.at_xpath(@xpath).class}"
        doc.at_xpath(@xpath).after Nokogiri::XML::Text.new(@value, doc.document)
      when 'replace_collection'
        doc.xpath(@xpath).first.replace Nokogiri::XML::Text.new(@value, doc.document)
        doc.xpath(@xpath).each do |node|
          node.remove if node.is_a? Nokogiri::XML::Element
        end
      end
      doc
    end
  end
end