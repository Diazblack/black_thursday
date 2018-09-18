require_relative './modules/mathematics'

class Customer
  include Mathematics

  attr_reader :id,
              :first_name,
              :last_name,
              :created_at,
              :updated_at

  def initialize(hash)
    @id = hash[:id].to_i
    @first_name = hash[:first_name]
    @last_name = hash[:last_name]
    @created_at = transform_to_time(hash[:created_at])
    @updated_at = transform_to_time(hash[:updated_at])

  end

  def change_attributes(attributes)
    @first_name = hash[:first_name] if hash[:first_name] != nil
    @last_name = hash[:last_name] if hash[:last_name] != nil
    @updated_at = Time.now
  end
end
