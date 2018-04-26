require "test_helper"
require 'flowcation'

class TemplateTest < Minitest::Test
  
   
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
  
  def test_template
    template = Flowcation::Template.new \
      Nokogiri::HTML(@html).xpath("//html"), 
      nil, 
      'path', 
      nil, 
      [],
      nil
      
      puts template.content
    assert_equal @html, template.content
  end
end
