require_relative 'merchant_repository'
require_relative 'item_repository'

class SalesEngine
  attr_reader :items,
              :merchants

  def initialize(hash)
    @items = hash[:items]
    @merchants = hash[:merchants]

  end

  def self.from_csv(hash)
    classes = {
      items: ItemRepository,
      merchants: MerchantRepository
    }

    new_hash = Hash.new(0)
    hash.each_pair do |key, path|
      if classes[key] != nil
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

  def hash_of_items_number_by_merchant_id
    @merchants.repository. inject({}) do |hash, merchant|
      item = @items.find_all_by_merchant_id(merchant.id)
      hash[merchant.id] = item.length if item.length > 0
      hash
    end
  end
end
