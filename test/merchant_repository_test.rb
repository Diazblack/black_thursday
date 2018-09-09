require_relative 'minitest_helper'

require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'

class MerchantRepositoryTest < Minitest::Test
  def test_if_exist
    merchant_storage = MerchantRepository.new(./data/test_data/merchants.cvs)

    assert_instance_of MerchantRepository,
    merchant_storage
  end

  def test_if_it_can_get_merchants
    merchant_storage = MerchantRepository.new(./data/test_data/merchants.cvs)

    assert_equal 9, merchant_storage.all.lenght
  end


end
