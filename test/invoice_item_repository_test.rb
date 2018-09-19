require_relative 'minitest_helper'

require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @invoice_items = InvoiceItemRepository.new("./data/test_data/invoice_items.csv")
  end

  def test_if_exist
    assert_instance_of InvoiceItemRepository, @invoice_items
  end

  def test_if_it_can_get_all_invoices_and_attributes
    assert_instance_of Array, @invoice_items.all
    assert_equal 100, @invoice_items.all.length
    @invoice_items.all.each do |invoice_item|
      assert_instance_of InvoiceItem, invoice_item
      assert_instance_of Time , invoice_item.created_at
      assert_instance_of Time , invoice_item.updated_at
    end
    assert_equal 263395237, @invoice_items.all[19].item_id
    assert_equal 1, @invoice_items.all[31].quantity
    assert_equal 401.87, @invoice_items.all[54].unit_price_to_dollars
  end

  def test_if_it_can_find_invoice_item_by_id
    invoice_item = @invoice_items.find_by_id(13)

    assert_equal 13, invoice_item.id
    assert_equal 263553176, invoice_item.item_id
  end

  def test_if_it_can_find_all_by_item_id
    invoice_item = @invoice_items.find_all_by_item_id(263406625)

    assert_instance_of Array, invoice_item
    assert_equal 100, invoice_item.first.id
  end

  def test_if_it_can_find_all_by_invoice_id
    invoice_item = @invoice_items.find_all_by_invoice_id(17)

    assert_instance_of Array, invoice_item
    assert_equal 4, invoice_item.count
    assert_equal 84, invoice_item.first.id
  end

  def test_if_it_can_create_and_delete_an_invoice_item
    hash = {
      :id => 6,
      :item_id => 3280779,
      :invoice_id => 8,
      :quantity => 200,
      :unit_price => BigDecimal.new(510.45, 5),
      :created_at => Time.now,
      :updated_at => Time.now
    }

    @invoice_items.create(hash)

    assert_instance_of InvoiceItem, @invoice_items.all.last
    assert_equal 101, @invoice_items.all.last.id
    assert_equal 3280779, @invoice_items.all.last.item_id

    @invoice_items.delete(101)

    assert_nil @invoice_items.find_by_id(101)
    assert_equal 100, @invoice_items.all.count
  end

  def test_if_it_can_update_an_invoice_item
    hash = {
      :id => 6,
      :item_id => 3280779,
      :invoice_id => 8,
      :quantity => 200,
      :unit_price => BigDecimal.new(510.45, 5),
      :created_at => Time.now,
      :updated_at => Time.now
    }

    @invoice_items.update(50, hash)

    assert_equal 50, @invoice_items.all[49].id
    assert_equal 200, @invoice_items.all[49].quantity
    assert_equal 510.45, @invoice_items.all[49].unit_price_to_dollars
  end
end
