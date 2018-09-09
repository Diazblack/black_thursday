require 'CSV'
require_relative 'merchant'
require_relative './modules/repository'

class MerchantRepository
  include Repository

  attr_reader :repository

  def initialize(path)
    @repository = []
    get_merchants(path)
  end

  def get_merchants(path)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row_hash|
      @repository << Merchant.new(row_hash)
    end
  end

end
