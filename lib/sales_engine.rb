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
end
