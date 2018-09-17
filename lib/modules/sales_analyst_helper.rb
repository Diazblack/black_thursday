require_relative 'mathematics'

module SalesAnalystHelper
  include Mathematics

  def array_of_average_price_per_merchant
    @engine.merchants.all.map do |merchant|
      average_item_price_for_merchant(merchant.id)
    end
  end

  def find_all_stuff_by_id(stuff, to_look, limit, direction)
    stuff.inject([]) do |array, (key, value)|
      hash = to_look.find_by_id(key)
      if nil != hash  && value > limit && direction
        array << hash
      elsif nil != hash  && value < limit && !direction
        array << hash
      else
        array
      end
    end
  end

  def merchant_invoices(direction, limit)
    merchant_invoices = @engine.hash_of_invoices_number_by_merchant_id
    to_look = @engine.merchants
    find_all_stuff_by_id(merchant_invoices, to_look, limit, direction)
  end
end
