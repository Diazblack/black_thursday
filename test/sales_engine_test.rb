require_relative 'minitest_helper'

require_relative '../lib/sales_engine'
require_relative '../lib/merchant_repository'
require_relative '../lib/item_repository'

class SalesEngineTest < Minitest::Test
  def test_if_exist
    hash = {
      :items     => "./data/test_data/items.csv",
      :merchants => "./data/test_data/merchants.csv",
    }
    se = SalesEngine.new(hash)

    assert_instance_of SalesEngine, se
  end

  def test_that_it_can_initialize_repositories
    hash = {
      :items     => "./data/test_data/items.csv",
      :merchants => "./data/test_data/merchants.csv",
    }
    se = SalesEngine.from_csv(hash)

    # Item repository assertions
    assert_equal 5, se.items.all.length
    assert_instance_of Array, se.items.all
    se.items.all.each do |item|
      assert_instance_of Item, item
    end
    assert_equal "510+ RealPush Icon Set", se.items.all.first.name

    # Merchant repository assertions
    assert_equal 11, se.merchants.all.length
    assert_instance_of Array, se.merchants.all
     se.merchants.all.each do |merchant|
       assert_instance_of Merchant, merchant
     end
    assert_equal "Shopin1901", se.merchants.all.first.name
  end

  def test_if_it_can_an_array_with_the_amount_of_item_by_sold_by_merchant
    hash = {
      :items     => "./data/test_data/items.csv",
      :merchants => "./data/test_data/merchants.csv",
    }
    se = SalesEngine.from_csv(hash)

    expected = [1,0,0,0,0,0,0,1,0,0,3]
    assert_equal expected, se.number_of_items_by_merchant
  end

  def test_if_it_can_an_hash_with_the_amount_of_item_by_sold_by_merchant_id_greater_then_cero
    hash = {
      :items     => "./data/test_data/items.csv",
      :merchants => "./data/test_data/merchants.csv",
    }
    se = SalesEngine.from_csv(hash)

    expected = {12334141 => 1, 12334105 => 1, 12334185 => 3}
    assert_equal expected, se.hash_of_items_number_by_merchant_id
  end
end
