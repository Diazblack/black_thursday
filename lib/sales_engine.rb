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

  end
end
