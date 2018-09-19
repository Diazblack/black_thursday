require_relative 'sales_engine'
require_relative './modules/mathematics'
require_relative './modules/sales_analyst_helper'
require 'pry'

class SalesAnalyst
  include Mathematics
  include SalesAnalystHelper

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
    to_look = @engine.merchants
    direction = true
    find_all_stuff_by_id(merchant_id, to_look, limit, direction )
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
    limit = average_invoices_per_merchant
    limit += (average_invoices_per_merchant_standard_deviation * 2)
    direction = true
    merchant_invoices(direction, limit)
  end

  def bottom_merchants_by_invoice_count
    limit = average_invoices_per_merchant
    limit -= (average_invoices_per_merchant_standard_deviation * 2)
    direction = false
    merchant_invoices(direction, limit)
  end

  def top_days_by_invoice_count
    hash = @engine.invoices.find_all_by_day_created_at
    limit = (average_from_array(hash) + standard_diviation_array(hash)).round
    hash.inject([]) do |array, (key, value)|
      if key != nil && value > limit
        array << key
      else
        array
      end
    end
  end

  def invoice_status(status)
    data_1 = @engine.invoices.find_all_by_status(status).count
    data_2 = @engine.invoices.all.count
    percentage(data_1, data_2)
  end

  def invoice_paid_in_full?(id_to_find)
    transactions = @engine.transactions.find_all_by_invoice_id(id_to_find)
    transactions.any? do |transaction|
      transaction.result == :success
    end
  end

  def invoice_total(id_to_find)
  end 
end
