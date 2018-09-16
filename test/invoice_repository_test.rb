require_relative 'minitest_helper'

require_relative '../lib/invoice_repository'

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
    assert_equal "shipped", @invoices.all[15].status
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

end
