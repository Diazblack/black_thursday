require_relative 'item'
require_relative './modules/repository'
require_relative './modules/csv_adapter'
require 'Time'

class ItemRepository
  include Repository
  include CSVAdapter

  attr_reader :repository

  def initialize(path)
    @repository = []
    @class = Item
    get_stuff(path, @class)
  end

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

  def create(hash)
    create_stuff(hash, @class)
  end

  def find_all_with_description(words)
    @repository.find_all do |item|
      item.description.downcase.include?(words.downcase)
    end
  end

  def find_all_by_merchant_id(id)
    @repository.find_all do |item|
      item.merchant_id == id
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
end
