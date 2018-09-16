require_relative 'item'
require_relative './modules/repository'
require_relative './modules/csv_adapter'

class ItemRepository
  include Repository
  include CSVAdapter

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
    @repository.find_all do |item|
      item.description.downcase.include?(words.downcase)
    end
  end

  def find_all_by_price(money)
    @repository.find_all do |item|
      item.unit_price == money
    end
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
