require_relative 'sales_engine'
require_relative './modules/mathematics'

class SalesAnalyst
  include Mathematics
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

  def average_items_per_merchant
    sum_of_items = sum_of_integers(@engine.number_of_items_by_merchant)
    merchants_length = @engine.merchants.all.length
    average_number(sum_of_items, merchants_length)
  end

  def average_items_per_merchant_standart_deviation
    array_of_items = @engine.number_of_items_by_merchant
    sum_all_integers = sum_of_integers(array_of_items)
    average = average_items_per_merchant
    subtract = subtract_index(array_of_items, average)
    sum_square_numbers = sum_of_integers(square_numbers(subtract))
    standart = sum_square_numbers / array_of_items.length
    Math.sqrt(standart).round(2)
  end

  def merchants_with_high_item_count
    
  end

end
