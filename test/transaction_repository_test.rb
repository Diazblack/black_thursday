require_relative 'minitest_helper'

require_relative '../lib/transaction_repository'
require_relative '../lib/transaction'

class TransactionTest < Minitest::Test
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
    expected_1 = 4240970000331800
    assert_equal expected_1, @transactions.all[43].credit_card_number
    assert_equal 259, @transactions.all[258].id
    assert_equal "failed", @transactions.all[190].result
    assert_equal 115, @transactions.all[369].credit_card_expiration_date
  end

end
