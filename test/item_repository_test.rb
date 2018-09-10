require_relative 'minitest_helper'

require_relative '../lib/item_repository'
require_relative '../lib/item'
require_relative '../lib/modules/repository'

class ItemRepositoryTest < Minitest::Test
  def test_if_exist
    item_storage = ItemRepository.new("./data/test_data/items.csv")

    assert_instance_of ItemRepository, item_storage
  end

  def test_if_it_can_get_items
    items_storage = ItemRepository.new("./data/test_data/items.csv")

    assert_equal 5, items_storage.all.length
    assert_instance_of Array, items_storage.all
    items_storage.all.each do |item|
      assert_instance_of Item, item
    end
    assert_equal "510+ RealPush Icon Set", items_storage.all.first.name
  end
end
