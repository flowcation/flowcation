require "test_helper"
require 'flowcation'

class SubstitutionTest < Minitest::Test
   
  def setup
    @html = %q(
<html>
  <head>
  </head>
  <body>
    <div>content</div>
    <div class="attribute"></div>
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
    substituted = content_substitution.apply(@doc)
    assert_match '<%= substitution %>',  Flowcation::Render.sanitize(substituted.to_html)
  end
end
