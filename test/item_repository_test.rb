require_relative 'minitest_helper'

require_relative '../lib/item_repository'
require_relative '../lib/item'

class ItemRepositoryTest < Minitest::Test
  def test_if_exist
    item_storage = ItemRepository.new

    assert_instance_of ItemRepository, item_storage
  end
end
