require_relative 'minitest_helper'

require_relative '../lib/item'

class ItemTest < Minitest::Test
  def test_if_exist
    item = Item.new({
      :id          => "1",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => "2"
    })

    assert_instance_of Item, item
  end

  def test_if_can_store_attributes
    item = Item.new({
      :id          => "1",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => "2"
    })

    assert_equal 1, item.id
    assert_equal "Pencil", item.name
    assert_equal "You can use it to write things", item.description
    assert_instance_of BigDecimal, item.unit_price
    assert_instance_of Time , item.created_at
    assert_instance_of Time , item.updated_at
    assert_equal 2, item.merchant_id
  end

  def test_if_it_can_transform_in_a_big_decimal_if_it_isnt
    item = Item.new({
      :id          => "1",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => "1099",
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => "2"
    })

    assert_instance_of BigDecimal, item.unit_price
    assert_equal 10.99, item.unit_price_to_dollars

  end

  def test_if_it_can_transform_strings_in_Time_objects
    item = Item.new({
      :id          => "1",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => "1099",
      :created_at  => "2002-01-01 00:00:00 -0500",
      :updated_at  => "2002-01-01 00:00:00 -0500",
      :merchant_id => "2"
    })

    assert_instance_of Time, item.created_at
    assert_instance_of Time, item.updated_at

  end

  def test_if_it_can_get_price_on_dollars
    item = Item.new({
      :id          => "1",
      :name        => "Pencil",
      :description => "You can use it to write things",
      :unit_price  => BigDecimal.new(10.99,4),
      :created_at  => Time.now,
      :updated_at  => Time.now,
      :merchant_id => "2"
    })

    assert_equal 10.99, item.unit_price_to_dollars
  end

end
