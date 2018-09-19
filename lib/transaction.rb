require_relative './modules/mathematics'

class Transaction
  include Mathematics

  attr_reader :id,
              :invoice_id,
              :credit_card_number,
              :credit_card_expiration_date,
              :result,
              :created_at,
              :updated_at

  def initialize(hash)
    @id = hash[:id].to_i
    @invoice_id = hash[:invoice_id].to_i
    @credit_card_number = hash[:credit_card_number]
    @credit_card_expiration_date = hash[:credit_card_expiration_date]
    @result = hash[:result].to_sym
    @created_at = transform_to_time(hash[:created_at])
    @updated_at = transform_to_time(hash[:updated_at])
  end

  def change_attributes(attributes)
    if attributes[:credit_card_number] != nil
      @credit_card_number = attributes[:credit_card_number]
    end
    if attributes[:credit_card_expiration_date] != nil
      @credit_card_expiration_date = attributes[:credit_card_expiration_date]
    end
    @result = attributes[:result] if attributes[:result] != nil

    @updated_at = Time.now
  end
end
