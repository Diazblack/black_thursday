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
    assert_equal 10, se.merchants.all.length
    assert_instance_of Array, se.merchants.all
     se.merchants.all.each do |merchant|
       assert_instance_of Merchant, merchant
     end
    assert_equal "Shopin1901", se.merchants.all.first.name
  end
end
