require_relative 'minitest_helper'

require_relative '../lib/invoice_item'

class InvoiceItemTest < Minitest::Test
  def setup
    @item_invoice = InvoiceItem.new({
      :id => 6,
      :item_id => 7,
      :invoice_id => 8,
      :quantity => 1,
      :unit_price => BigDecimal.new(10.99, 4),
      :created_at => Time.now,
      :updated_at => Time.now
    })
  end

  def test_if_exist
    assert_instance_of InvoiceItem, @item_invoice
  end

  def test_if_has_attributes
     assert_equal 6, @item_invoice.id
     assert_equal 7, @item_invoice.item_id
     assert_equal 8, @item_invoice.invoice_id
     assert_equal 1, @item_invoice.quantity
     assert_instance_of BigDecimal, @item_invoice.unit_price
     assert_instance_of Time , @item_invoice.created_at
     assert_instance_of Time , @item_invoice.updated_at
  end

  def test_if_it_can_price_in_dollars
    assert_equal 10.99, @item_invoice.unit_price_to_dollars
  end
end
