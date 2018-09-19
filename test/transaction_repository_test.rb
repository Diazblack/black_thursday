require_relative 'minitest_helper'

require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'

class TransactionRepositoryTest < Minitest::Test

  def setup
    @transactions = TransactionRepository.new("./data/transactions.csv")
  end

  def test_if_exist
    assert_instance_of TransactionRepository, @transactions
  end

  def test_if_can_store_and_return_all_transactions
    assert_instance_of Array, @transactions.all
    assert_equal 4985, @transactions.all.length
    assert_instance_of Transaction, @transactions.all[1111]
    expected_1 = "4240970000331800"
    assert_equal expected_1, @transactions.all[43].credit_card_number
    assert_equal 259, @transactions.all[258].id
    assert_equal :failed, @transactions.all[190].result
    assert_equal "0115", @transactions.all[369].credit_card_expiration_date
  end

  def test_if_it_can_find_by_id
    transaction = @transactions.find_by_id(2615)

    assert_equal "4329353232293980", transaction.credit_card_number
  end

  def test_if_it_can_find_all_by_invoice_id
    transaction = @transactions.find_all_by_invoice_id(2179)

    assert_equal 2, transaction.count
    assert_instance_of Transaction, transaction.first
  end

  def test_if_it_can_find_all_by_credit_card_number
    credit_card = "4848466917766329"
    transaction = @transactions.find_all_by_credit_card_number(credit_card)

    assert_equal 1, transaction.count
    assert_equal credit_card, transaction.first.credit_card_number
  end

  def test_if_it_can_find_all_by_result
    result = :success
    transaction = @transactions.find_all_by_result(result)

    assert_equal 4158, transaction.count
    assert_instance_of Transaction, transaction.first
    assert_equal result, transaction.first.result
  end

  def test_if_it_can_create_and_delete_a_transaction
    hash = {
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    }
    @transactions.create(hash)

    expected = "4242424242424242"
    assert_equal expected, @transactions.all.last.credit_card_number
    assert_equal 8, @transactions.find_by_id(4986).invoice_id

    @transactions.delete(4986)

    assert_nil @transactions.find_by_id(4986)
  end

  def test_if_can_update_a_transactions_attributes
    hash = {
      :invoice_id => 8,
      :credit_card_number => "4242424242424242",
      :credit_card_expiration_date => "0220",
      :result => "success",
      :created_at => Time.now,
      :updated_at => Time.now
    }

    @transactions.update(4985,hash)

    assert_equal 3791, @transactions.find_by_id(4985).invoice_id
    expected = "4242424242424242"
    assert_equal expected, @transactions.find_by_id(4985).credit_card_number
  end
end
