require_relative 'minitest_helper'

require_relative '../lib/invoice_item_repository'
require_relative '../lib/invoice_item'

class InvoiceItemRepositoryTest < Minitest::Test
  def setup
    @invoice_items = InvoiceRepository.new("./data/invoice_items.csv")
  end

  def test_if_exist
    assert_instance_of InvoiceItemRepository, @invoice_items
  end
end
