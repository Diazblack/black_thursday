require_relative 'minitest_helper'

require_relative '../lib/sales_engine'
require_relative '../lib/sales_analyst'


class SalesEngineTest < Minitest::Test
  def setup
    hash = {
      items:      "./data/test_data/items.csv",
      merchants:  "./data/test_data/merchants.csv",
      invoices:   "./data/test_data/invoices.csv",
      invoice_item: "./data/test_data/invoice_items.csv",
      transactions: "./data/transactions.csv"
    }
    @sales_engine = SalesEngine.from_csv(hash)
  end

  def test_if_exist
    assert_instance_of SalesEngine, @sales_engine
  end

  def test_that_it_can_initialize_repositories
    # Item repository assertions
    assert_equal 5, @sales_engine.items.all.length
    assert_instance_of Array, @sales_engine.items.all
    @sales_engine.items.all.each do |item|
      assert_instance_of Item, item
    end
    assert_equal "510+ RealPush Icon Set", @sales_engine.items.all.first.name

    # Merchant repository assertions
    assert_equal 11, @sales_engine.merchants.all.length
    assert_instance_of Array, @sales_engine.merchants.all
    @sales_engine.merchants.all.each do |merchant|
       assert_instance_of Merchant, merchant
     end
    assert_equal "Shopin1901", @sales_engine.merchants.all.first.name

    #Invoice repository assertions
    assert_equal 20, @sales_engine.invoices.all.length
    assert_instance_of Array, @sales_engine.invoices.all
    @sales_engine.invoices.all.each do |invoice|
       assert_instance_of Invoice, invoice
     end
  end

  def test_if_it_can_get_an_array_with_the_amount_of_item_by_sold_by_merchant
    expected = [1,0,0,0,0,0,0,1,0,0,3]
    assert_equal expected, @sales_engine.number_of_items_by_merchant
  end

  def test_if_it_can_get_an_array_with_the_price_of_items_by_sold_by_merchant
    array_of_prices = @sales_engine.price_of_items_by_merchant(12334185)

    assert_equal 3 , array_of_prices.length
    array_of_prices.each do |price|
      assert_instance_of BigDecimal, price
    end
  end

  def test_if_it_can_an_hash_with_the_amount_of_item_by_sold_by_merchant_id_greater_then_cero
    expected = {12334141 => 1, 12334105 => 1, 12334185 => 3}
    assert_equal expected, @sales_engine.hash_of_items_number_by_merchant_id
  end
end
