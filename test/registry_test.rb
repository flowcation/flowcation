require "test_helper"
require 'flowcation'

class RegistryTestClass
  include Flowcation::Registry
  register :list_items, type: :list
  register :settings
end

class RegistryTest < Minitest::Test
   
  def setup
    @register = RegistryTestClass.new
    @hash = {a: 'b', c: 'd'}
  end
  
  def test_list_registry
    (1..3).each { |i| @register.register_list_item i }
    assert_equal @register.list_items, [1,2,3]
  end
  
  def test_registry
    {a: 'b', c: 'd'}.each do |k,v| 
      @register.register_setting k,v 
    end
    
    assert_equal @register.settings, {a: 'b', c: 'd'}
  end
end
