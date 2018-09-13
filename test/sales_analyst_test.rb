require_relative 'minitest_helper'

require_relative '../lib/sales_analyst'

class SalesAnalystTest < Minitest::Test

  def test_if_exist
    hash = {
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    }
    sales_engine = SalesEngine.from_csv(hash)
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_instance_of SalesAnalyst, sales_analyst
  end

  def test_if_it_can_get_the_average_items_per_merchant
    hash = {
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    }
    sales_engine = SalesEngine.from_csv(hash)
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_equal 2.88, sales_analyst.average_items_per_merchant
  end

  def test_if_it_can_get_the_average_items_per_merchant_standart_deviation
    hash = {
      :items     => "./data/items.csv",
      :merchants => "./data/merchants.csv",
    }
    sales_engine = SalesEngine.from_csv(hash)
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_equal 3.26, sales_analyst.average_items_per_merchant_standart_deviation
  end

  def test_if_it_can_get_merchants_with_high_item_count
    hash = {
      :items     => "./data/test_data/items.csv",
      :merchants => "./data/test_data/merchants.csv",
    }

    sales_engine = SalesEngine.from_csv(hash)
    sales_analyst = SalesAnalyst.new(sales_engine)

    assert_equal 3 , sales_analyst.merchants_with_high_item_count.length
  end
end
