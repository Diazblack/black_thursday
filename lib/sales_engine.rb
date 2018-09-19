require_relative 'merchant_repository'
require_relative 'item_repository'
require_relative 'invoice_repository'
require_relative 'invoice_item_repository'
require_relative 'transaction_repository'
require_relative 'customer_repository'

require_relative './modules/mathematics'

class SalesEngine
  include Mathematics

  attr_reader :items,
              :merchants,
              :analyst,
              :invoices,
              :invoice_items,
              :transactions,
              :customers

  def initialize(hash)
    @items = hash[:items]
    @merchants = hash[:merchants]
    @analyst = SalesAnalyst.new(self)
    @invoices = hash[:invoices]
    @invoice_items = hash[:invoice_items]
    @transactions = hash[:transactions]
    @customers = hash[:customers]
  end

  def self.from_csv(hash)
    classes = {
      items: ItemRepository,
      merchants: MerchantRepository,
      invoices: InvoiceRepository,
      invoice_items: InvoiceItemRepository,
      transactions: TransactionRepository,
      customers: CustomerRepository
    }

    new_hash = Hash.new(0)
    hash.each_pair do |key, path|
      if classes[key] != nil && path != nil
        new_hash[key] = classes[key].new(path)
      end
    end
    self.new(new_hash)
  end

  def number_of_items_by_merchant
    @merchants.repository.map do |merchant|
      items = @items.find_all_by_merchant_id(merchant.id)
      items.length
    end
  end

  def price_of_items_by_merchant(id)
    items = @items.find_all_by_merchant_id(id)
    return [0]  if items == []
    items.map do |item|
      item.unit_price
    end
  end

  def hash_of_items_number_by_merchant_id
    @merchants.repository. inject({}) do |hash, merchant|
      item = @items.find_all_by_merchant_id(merchant.id)
      hash[merchant.id] = item.length if item.length > 0
      hash
    end
  end

  def number_of_invoices_by_merchant
    @merchants.repository.map do |merchant|
      invoice = @invoices.find_all_by_merchant_id(merchant.id)
      invoice.length
    end
  end

  def hash_of_invoices_number_by_merchant_id
    @merchants.repository. inject({}) do |hash, merchant|
      invoices = @invoices.find_all_by_merchant_id(merchant.id)
      hash[merchant.id] = invoices.length if invoices.length > 0
      hash
    end
  end
end
