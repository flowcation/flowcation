require "test_helper"
require 'flowcation'

module LayoutHelper
  def self.image_tag_helper(node)
    attributes = node.attributes.reject{|k,v| k == 'src' }.map {|k,v| v}.map {|a| "'#{a.name}' => '#{a.value}'"}.join(", ")
    %Q(<%= image_tag 'test', #{attributes} %>)
  end
end

class SubstitutionTest < Minitest::Test
  
  def s(html)
    Flowcation::Render.sanitize(html)
  end
   
  def setup
    @html = %q(
<html>
  <head>
  </head>
  <body>
    <div>content</div>
    <div class="attribute"></div>
    <img class="klazz" src="img/image.jpg"></img>
    <img class="klazz klazz-2" data-action="click->controller#action" src="img/image.jpg">
  </body>
</html>
    )
    @doc = Nokogiri::HTML(@html)
  end
  
  def test_content_substitution
    content_substitution = Flowcation::Substitution.new \
      :content_substitution, 
      '//div[1]', 
      'content', 
      '<%= substitution %>', 
      nil
    substituted = s(content_substitution.apply(@doc).to_html)
    assert_match '<%= substitution %>',  substituted
    refute_match '<div>content</div>',  substituted
  end
  
  def test_replace_each_substitution_with_image_tag_helper
    content_substitution = Flowcation::Substitution.new \
      :content_substitution,
      '//descendant::img',
      'replace_each',
      'image_tag_helper',
      nil
    substituted = s(content_substitution.apply(@doc).to_html)
    assert_match "<%= image_tag 'test', 'class' => 'klazz' %>", substituted
    assert_match "<%= image_tag 'test', 'class' => 'klazz klazz-2', 'data-action' => 'click->controller#action' %>", substituted
    refute_match '<img class="klazz" src="img/image.jpg"></img>', substituted
  end
end
