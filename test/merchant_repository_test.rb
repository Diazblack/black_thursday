require_relative 'minitest_helper'

require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'
require_relative '../lib/modules/repository'

class MerchantRepositoryTest < Minitest::Test
  def test_if_exist
    merchant_storage = MerchantRepository.new("./data/test_data/merchants.cvs")

    assert_instance_of MerchantRepository,
    merchant_storage
  end

  def test_if_it_can_get_merchants
    merchant_storage = MerchantRepository.new("./data/test_data/merchants.cvs")

    assert_equal 9, merchant_storage.all.length
    assert_instance_of Array, merchant_storage.all
    assert_instance_of Merchant, merchant_storage.all.first
    assert_equal "Shopin1901", merchant_storage.all.first.name
  end


end
