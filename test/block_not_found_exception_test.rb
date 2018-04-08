require "test_helper"

class BlockNotFoundExceptionTest < Minitest::Test
  def setup
    @block_not_found_exception = Flowcation::BlockNotFoundException.build \
      xpath: '//div[@class="xpath"]', 
      path: "name"
  end
  
  def test_raise_block_not_found_exception
    assert_raises Flowcation::BlockNotFoundException do
      raise @block_not_found_exception
    end
  end
end
