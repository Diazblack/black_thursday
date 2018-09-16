require_relative 'minitest_helper'

require_relative '../lib/item_repository'

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
      :unit_price  => BigDecimal(10.99,4),
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

    items_storage.delete(263395721)

    assert_nil items_storage.find_by_id(263395721)
  end

  def test_if_it_can_update_an_item_by_only_modifying_3_attributes
    items_storage = ItemRepository.new("./data/test_data/items.csv")
    attributes = {
      :id          => 1111,
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => 10.99,
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => "2"
    }
    id = 263395617

    items_storage.update(id, attributes)
    item = items_storage.find_by_name("pencil")

    assert_equal 263395617, item.id
    assert_equal "Pencil" , item.name
    assert_equal 10.99, item.unit_price_to_dollars
    assert_equal 12334185, item.merchant_id
  end

  def test_if_it_can_find_all_with_description_and_retun_empty_array_if_doesnt
    items_storage = ItemRepository.new("./data/test_data/items.csv")

    items = items_storage.find_all_with_description("frames")
    expected = [items_storage.repository[1], items_storage.repository[2]]
    assert_equal expected, items

    items_2 = items_storage.find_all_with_description("Minato")

    assert_equal [], items_2
  end

  def test_if_it_can_find_all_with_mechant_id_and_retun_empty_array_if_doesnt
    items_storage = ItemRepository.new("./data/test_data/items.csv")

    items = items_storage.find_all_by_merchant_id(12334185)

    expected = [items_storage.repository[1], items_storage.repository[2], items_storage.repository[3]]
    assert_equal expected, items

    items_2 = items_storage.find_all_by_merchant_id(23647326548723645)

    assert_equal [], items_2
  end

  def test_if_it_can_find_all_by_price_and_retun_empty_array_if_doesnt
    items_storage = ItemRepository.new("./data/test_data/items.csv")

    items = items_storage.find_all_by_price(12.00)

    expected = [items_storage.repository[0]]
    assert_equal expected, items

    items_2 = items_storage.find_all_by_price(120000.00)

    assert_equal [], items_2
  end

  def test_if_it_can_find_all_by_price_with_range_and_retun_empty_array_if_doesnt
    items_storage = ItemRepository.new("./data/test_data/items.csv")

    items = items_storage.find_all_by_price_in_range(10.00..15.00)

    expected = [items_storage.repository[0], items_storage.repository[1], items_storage.repository[2]]
    assert_equal expected, items

    items_2 = items_storage.find_all_by_price_in_range(100_000_000.00..150_000_000.00)

    assert_equal [], items_2
  end

  def test_if_it_can_get_an_array_with_all_the_prices
    items_storage = ItemRepository.new("./data/test_data/items.csv")

    items = items_storage.array_prices_items

    assert_equal 5, items.length
    items.each do |price|
      assert_instance_of BigDecimal, price
    end
  end
end
