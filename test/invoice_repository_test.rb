require_relative 'minitest_helper'

require_relative '../lib/invoice_repository'
require_relative '../lib/invoice'

class InvoiceRepositoryTest < Minitest::Test
  def setup
    @invoices = InvoiceRepository.new("./data/test_data/invoices.csv")
  end

  def test_if_exist
    assert_instance_of InvoiceRepository, @invoices
  end

  def test_if_it_can_get_all_invoices_and_attributes
    assert_equal 20, @invoices.all.length
    assert_instance_of Array, @invoices.all
    @invoices.all.each do |invoice|
      assert_instance_of Invoice, invoice
      assert_instance_of Time , invoice.created_at
      assert_instance_of Time , invoice.updated_at
    end
    assert_equal 2, @invoices.all[8].customer_id
    assert_equal 12334771, @invoices.all[10].merchant_id
    assert_equal :shipped, @invoices.all[15].status
  end

  def test_if_it_can_find_invoice_by_id
    invoice = @invoices.find_by_id(13)
    assert_equal 13, invoice.id
    assert_equal 12335955, invoice.merchant_id
  end

  def test_if_it_can_find_all_invoices_by_customer_id
    invoice = @invoices.find_all_by_customer_id(1)

    assert_equal 8, invoice.length
    assert_equal 12334269, invoice[3].merchant_id

    invoice_2 = @invoices.find_all_by_customer_id(10000)
    assert_equal [], invoice_2
  end

  def test_if_it_can_find_all_invoices_by_merchant_id
    invoice = @invoices.find_all_by_merchant_id(12335955)

    assert_equal 2, invoice.length
    assert_equal 1, invoice[0].customer_id

    invoice_2 = @invoices.find_all_by_merchant_id(10000)
    assert_equal [], invoice_2
  end

  def test_if_it_can_find_all_invoices_by_status
    invoice = @invoices.find_all_by_status('Pending')

    assert_equal 9, invoice.length
    assert_equal 2, invoice[5].customer_id

    invoice_2 = @invoices.find_all_by_merchant_id("Puka")
    assert_equal [], invoice_2
  end

  def test_if_it_can_create_and_delete_an_invoice
    hash = {
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "pending",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }

    invoice = @invoices

    invoice.create(hash)

    assert_equal 21, invoice.all.length
    assert_equal 7, invoice.all[20].customer_id

    invoice.delete(21)
    assert_nil invoice.find_by_id(21)
  end

  def test_if_it_can_update_an_invoice_with_out_modifeying_other_attributes
    hash = {
      :id          => 6,
      :customer_id => 7,
      :merchant_id => 8,
      :status      => "Shipped",
      :created_at  => Time.now,
      :updated_at  => Time.now,
    }

    invoice = @invoices

    invoice.update( 4, hash)

    assert_equal 4, invoice.all[3].id
    assert_equal 1, invoice.all[3].customer_id
    assert_equal :shipped, invoice.all[3].status
  end
end
