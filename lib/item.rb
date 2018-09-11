require 'bigdecimal'
require 'bigdecimal/util'
require 'Time'
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
    @created_at = transform_to_time(hash[:created_at])
    @updated_at = transform_to_time(hash[:updated_at])
    @merchant_id = hash[:merchant_id].to_i

  end

  def change_attributes(attributes)
    @name = attributes[:name] if attributes[:name] != nil
    @description = attributes[:description] if attributes[:description] != nil
    @unit_price = attributes[:unit_price] if attributes[:unit_price] != nil
    @updated_at = Time.now
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

  def transform_to_time(data)
    if data.class != Time
      Time.parse(data)
    else
      data
    end
  end
end
