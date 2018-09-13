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
    binding.pry
    assert_instance_of SalesAnalyst, sales_analyst
  end
end
