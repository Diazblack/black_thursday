require_relative 'item'
require_relative './modules/repository'
require_relative './modules/csv_adapter'
require_relative './modules/find'

class ItemRepository
  include Repository
  include CSVAdapter
  include Find

  attr_reader :repository

  def initialize(path)
    @repository = []
    @class = Item
    get_stuff(path, @class)
  end

  def create(hash)
    create_stuff(hash, @class)
  end

  def find_all_with_description(words)
    find_all_by_string(words, "description")
  end

  def find_all_by_price(money)
    find_all_by_method(money, "unit_price")
  end

  def find_all_by_price_in_range(range)
    @repository.find_all do |item|
      range.include?(item.unit_price)
    end
  end

  def array_prices_items
    @repository.map do |item|
      item.unit_price
    end
  end
end
