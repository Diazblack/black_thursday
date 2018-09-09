require_relative 'minitest_helper'

require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'

class MerchantRepositoryTest < Minitest::Test
  def test_if_exist
    merchant_storage = MerchantRepository.new

    assert_instance_of MerchantRepository,
    merchant_storage
  end
end
