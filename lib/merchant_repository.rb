require 'CSV'
require_relative 'merchant'
require_relative './modules/repository'

class MerchantRepository
  include Repository

  attr_reader :repository

  def initialize(path)
    @repository = []
    @class = Merchant
    get_stuff(path, @class)
  end

  def create(hash)
    create_stuff(hash, @class)
  end

end
