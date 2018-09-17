require_relative 'sales_engine'
require_relative './modules/mathematics'
require 'pry'

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

  def average_items_per_merchant_standard_deviation
    array_of_items = @engine.number_of_items_by_merchant
    standard_diviation_array(array_of_items)
  end

  def merchants_with_high_item_count
    standart_deviation = average_items_per_merchant_standard_deviation
    limit = standart_deviation + average_items_per_merchant
    merchant_id = @engine.hash_of_items_number_by_merchant_id
    merchant_id.inject([]) do |array, (key, value)|
      hash = engine.merchants.find_by_id(key)
      if nil != hash  && value > limit
        array << hash
      else
        array
      end
    end
  end

  def average_item_price_for_merchant(id)
    array_prices = @engine.price_of_items_by_merchant(id)
    average = average_number(sum_of_integers(array_prices), array_prices.length)
    transform_to_big_decimal(average)
  end

  def average_average_price_per_merchant
    array_average = array_of_average_price_per_merchant
    sum = sum_of_integers(array_average)
    average = average_number(sum, @engine.merchants.all.length)
    transform_to_big_decimal(average)
  end

  def array_of_average_price_per_merchant
    @engine.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
  end

  def golden_items
    items = @engine.items.array_prices_items
    average = average_from_array(items)
    doble_standard_deviation = standard_diviation_array(items) * 2
    limit = average + doble_standard_deviation
    @engine.items.find_all_by_price_greater_or_lesser(limit, true)
  end

  def average_invoices_per_merchant
      sum_of_items = sum_of_integers(@engine.number_of_invoices_by_merchant)
      merchants_length = @engine.merchants.all.length
      average_number(sum_of_items, merchants_length)
  end

  def average_invoices_per_merchant_standard_deviation
    array_of_items = @engine.number_of_invoices_by_merchant
    standard_diviation_array(array_of_items)
  end

  def top_merchants_by_invoice_count
    limit = average_invoices_per_merchant + (average_invoices_per_merchant_standard_deviation * 2)
    hash_of_invoices_number_by_merchant_id.

    end
  end
end
