require_relative 'minitest_helper'

require_relative '../lib/merchant_repository'
require_relative '../lib/merchant'
require_relative '../lib/modules/repository'

class MerchantRepositoryTest < Minitest::Test
  def test_if_exist
    merchant_storage = MerchantRepository.new("./data/test_data/merchants.csv")

    assert_instance_of MerchantRepository,
    merchant_storage
  end

  def test_if_it_can_get_merchants_and_get_them_all
    merchant_storage = MerchantRepository.new("./data/test_data/merchants.csv")

    assert_equal 11, merchant_storage.all.length
    assert_instance_of Array, merchant_storage.all
     merchant_storage.all.each do |merchant|
       assert_instance_of Merchant, merchant
     end
    assert_equal "Shopin1901", merchant_storage.all.first.name
  end

  def test_if_it_can_get_merchants_by_id
    merchant_storage = MerchantRepository.new("./data/test_data/merchants.csv")

    merchant = merchant_storage.find_by_id(12334132)

    assert_equal "perlesemoi", merchant.name
    assert_instance_of Merchant, merchant
  end

  def test_if_wrong_id_returns_nil
    merchant_storage = MerchantRepository.new("./data/test_data/merchants.csv")

    merchant = merchant_storage.find_by_id(8882783723)

    assert_nil merchant
  end

  def test_if_it_can_find_name_and_return_nil_for_wrong_name
    merchant_storage = MerchantRepository.new("./data/test_data/merchants.csv")

    merchant_1 = merchant_storage.find_by_name("LolaMarleys")

    assert_equal 12334115, merchant_1.id #comparing the id to get the right merchant

    merchant_2 = merchant_storage.find_by_name("Naruto")

    assert_nil merchant_2
  end

  def test_if_it_can_find_by_name_and_return_nil_for_wrong_name
    merchant_storage = MerchantRepository.new("./data/test_data/merchants.csv")

    merchant_1 = merchant_storage.find_by_name("LolaMarleys")

    assert_equal 12334115, merchant_1.id #comparing the id to get the right merchant

    merchant_2 = merchant_storage.find_by_name("Naruto")

    assert_nil merchant_2
  end

  def test_if_it_can_find_all_by_name_and_return_empty_array_for_wrong_name
    merchant_storage = MerchantRepository.new("./data/test_data/merchants.csv")

    merchant_1 = merchant_storage.find_all_by_name("PERL")

    assert_equal 2, merchant_1.length
    assert_equal "perlesemoi", merchant_1[0].name
    assert_equal "Perladelmar",merchant_1[1].name

    merchant_2 = merchant_storage.find_all_by_name("Naruto")

    assert_equal [], merchant_2
  end

  def test_if_it_can_create_a_new_merchant
    merchant_storage = MerchantRepository.new("./data/test_data/merchants.csv")
    attributes = {
      name: "Turing School of Software and Design"
    }

    merchant_storage.create(attributes)

    assert_equal 12334186,
    merchant_storage.repository.last.id
    assert_equal "Turing School of Software and Design",
    merchant_storage.repository.last.name
  end

  def test_if_it_can_create_a_new_merchant_and_delete_two_merchants_by_id
    merchant_storage = MerchantRepository.new("./data/test_data/merchants.csv")
    attributes = {
      name: "Turing School of Software and Design"
    }

    merchant_storage.create(attributes)

    assert_equal 12334186,
    merchant_storage.repository.last.id
    assert_equal "Turing School of Software and Design",
    merchant_storage.repository.last.name


    merchant_storage.delete(12334186)

    assert_nil merchant_storage.find_by_id(12334186)

    merchant_storage.delete(12334115)

    assert_nil merchant_storage.find_by_id(12334115)
  end

  def test_if_it_can_update_name_but_not_id
    merchant_storage = MerchantRepository.new("./data/test_data/merchants.csv")
    id = 12334113
    attributes = { name: "Los Pollos Hermanos", id: 12345678}
    merchant_storage.update(id, attributes)

    assert_equal 12334113,
    merchant_storage.find_by_id(id).id
    assert_equal "Los Pollos Hermanos",
    merchant_storage.find_by_id(id).name
  end
end
