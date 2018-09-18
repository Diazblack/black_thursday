require_relative './modules/mathematics'

class InvoiceItem
  include Mathematics

  attr_reader :id,
              :item_id,
              :invoice_id,
              :quantity,
              :unit_price,
              :created_at,
              :updated_at

  def initialize(hash)
    @id = hash[:id].to_i
    @item_id = hash[:item_id].to_i
    @invoice_id = hash[:invoice_id].to_i
    @quantity = hash[:quantity]
    @unit_price = transform_to_big_decimal(hash[:unit_price])
    @created_at = transform_to_time(hash[:created_at])
    @updated_at = transform_to_time(hash[:updated_at])
  end

  def change_attributes(attributes)
    @quantity = attributes[:quantity] if attributes[:quantity] != nil
    @unit_price = attributes[:unit_price] if attributes[:unit_price] != nil
    @updated_at = Time.now
  end

end
