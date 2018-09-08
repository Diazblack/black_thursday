require_relative 'minitest_helper'

require_relative '../lib/merchant'

class MerchantTest < Minitest::Test

  def test_if_exist
    merchant = Merchant.new({:id => 5, :name => "Turing School"})

    assert_instance_of Merchant, merchant
  end
end
