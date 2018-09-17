require_relative './modules/mathematics'

class Invoice
  include Mathematics

  attr_reader :id,
              :customer_id,
              :merchant_id,
              :status,
              :created_at,
              :updated_at

  def initialize(hash)
    @id = hash[:id].to_i
    @customer_id = hash[:customer_id].to_i
    @merchant_id = hash[:merchant_id].to_i
    @status = hash[:status].downcase.to_sym
    @created_at = transform_to_time(hash[:created_at])
    @updated_at = transform_to_time(hash[:updated_at])

  end

  def change_attributes(attributes)
    @status = attributes[:status].downcase.to_sym if attributes[:status] != nil
    @updated_at = Time.now
  end
end
