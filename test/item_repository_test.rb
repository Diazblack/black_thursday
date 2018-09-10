require_relative 'minitest_helper'

require_relative '../lib/item_repository'
require_relative '../lib/item'
require_relative '../lib/modules/repository'

class ItemRepositoryTest < Minitest::Test
  def test_if_exist
    item_storage = ItemRepository.new("./data/test_data/items.csv")

    assert_instance_of ItemRepository, item_storage
  end

  def test_if_it_can_get_items_and_get_them_all
    items_storage = ItemRepository.new("./data/test_data/items.csv")

    assert_equal 5, items_storage.all.length
    assert_instance_of Array, items_storage.all
    items_storage.all.each do |item|
      assert_instance_of Item, item
    end
    assert_equal "510+ RealPush Icon Set", items_storage.all.first.name
  end

  def test_if_it_can_get_items_by_id_and_return_nil_if_doesnt
    items_storage = ItemRepository.new("./data/test_data/items.csv")

    item = items_storage.find_by_id(263396013)
    assert_equal "Free standing Woden letters", item.name

    item_2 = items_storage.find_by_id(3)
    assert_nil item_2
  end

  def test_if_it_can_get_items_by_name_and_return_if_doesnt
    items_storage = ItemRepository.new("./data/test_data/items.csv")

    item = items_storage.find_by_name("Free standing Woden letters")
    assert_equal 263396013, item.id

    item_2 = items_storage.find_by_name("Kakarroto")
    assert_nil item_2
  end

  def test_if_it_can_create_a_new_item_and_delete_other
    items_storage = ItemRepository.new("./data/test_data/items.csv")
    attributes = {
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => 10.99,
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => "2"
    }

    items_storage.create(attributes)
    assert_equal 263396210, items_storage.repository.last.id
    assert_equal "Pencil" , items_storage.repository.last.name
    assert_instance_of BigDecimal, items_storage.repository.last.unit_price
    assert_instance_of Time, items_storage.repository.last.created_at
    assert_instance_of Time, items_storage.repository.last.updated_at
    assert_equal 2, items_storage.repository.last.merchant_id

    item_2 = items_storage.delete(263395721)

    assert_nil items_storage.find_by_id(263395721)
  end

end
