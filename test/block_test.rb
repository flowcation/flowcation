require "test_helper"

class BlockTest < Minitest::Test
  def setup
    @block =  Flowcation::Block.new("name", {'xpath' => '//div[@class="xpath"]'})
  end
  
  def test_initialize_block
    assert_equal @block.name, "name"
    assert_equal @block.xpath, '//div[@class="xpath"]'
  end
end
