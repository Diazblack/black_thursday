require 'bigdecimal'
require 'bigdecimal/util'
class Item
  attr_reader :id,
              :name,
              :description,
              :unit_price,
              :created_at,
              :updated_at,
              :merchant_id

  def initialize(hash)
    @id = hash[:id].to_i
    @name = hash[:name]
    @description = hash[:description]
    @unit_price = transform_to_big_decimal(hash[:unit_price])
    @created_at = hash[:created_at]
    @updated_at = hash[:updated_at]
    @merchant_id = hash[:merchant_id].to_i

  end

  def change_attributes(attributes)
    @name = attributes[:name]
    @description = attributes[:description]
    @unit_price = attributes[:unit_price]
  end

  def unit_price_to_dollars
    @unit_price.to_f.round(2)
  end

  def transform_to_big_decimal(data)
    if data.class != BigDecimal
      string = data.insert( - 3, ".")
      BigDecimal.new(string)
    else
      data
    end
  end
end
