require_relative 'minitest_helper'

require_relative '../lib/customer_repository'

class CustomerRepositoryTest < Minitest::Test

  def setup
    @customers = CustomerRepository.new("./data/customers.csv")
  end

  def test_if_exist
    assert_instance_of CustomerRepository, @customers
  end

  def test_if_can_store_attributes
    assert_instance_of Array, @customers.all
    assert_equal 1000, @customers.all.length
    assert_instance_of Customer, @customers.all[510]
    assert_equal "Estel", @customers.all[154].first_name
    assert_equal "Ratke", @customers.all[258].last_name
    assert_instance_of Time, @customers.all[190].created_at
  end

  def test_if_it_can_find_by_id
    assert_equal "Favian", @customers.find_by_id(224).first_name
  end

  def test_if_can_find_all_by_a_fractment_of_first_name
    customer = @customers.find_all_by_first_name("oe")

    assert_equal 8, customer.count
    assert_instance_of Customer, customer[4]
  end

  def test_if_can_find_all_by_fractment_of_last_name
    customer = @customers.find_all_by_last_name("On")

    assert_equal 85, customer.count
    assert_instance_of Customer, customer[28]

  end

  def test_if_it_can_create_a_new_costumer_and_delete_it
    hash = {
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
    }

    @customers.create(hash)

    assert_equal "Joan", @customers.all.last.first_name
    assert_equal 1001, @customers.all.last.id
    assert_instance_of Time, @customers.find_by_id(1001).created_at

    @customers.delete(1001)

    assert_nil @customers.find_by_id(1001)
  end

  def test_if_it_can_update_some_attributes_from_customer
    hash = {
      :id => 6,
      :first_name => "Joan",
      :last_name => "Clarke",
      :created_at => Time.now,
      :updated_at => Time.now
    }

    @customers.update(501, hash)

    assert_equal "Joan", @customers.find_by_id(501).first_name
    assert_equal 501, @customers.find_by_id(501).id
  end
end
