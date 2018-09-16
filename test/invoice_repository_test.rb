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
  
end
