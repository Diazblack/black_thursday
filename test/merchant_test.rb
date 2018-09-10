require_relative 'minitest_helper'

require_relative '../lib/merchant'

class MerchantTest < Minitest::Test

  def test_if_exist
    merchant = Merchant.new({:id => "5", :name => "Turing School"})

    assert_instance_of Merchant, merchant
  end

  def test_if_can_store_attributes
    merchant = Merchant.new({:id => "5", :name => "Turing School"})

    assert_equal 5, merchant.id
    assert_equal "Turing School", merchant.name
  end

  def test_if_can_change_attributes_but_not_id
    merchant = Merchant.new({:id => "5", :name => "Turing School"})
    attributes = { name: "Los Pollos Hermanos" }

    merchant.change_attributes(attributes)

    assert_equal "Los Pollos Hermanos", merchant.name
    assert_equal 5, merchant.id
  end
end
