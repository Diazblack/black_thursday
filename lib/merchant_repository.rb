require_relative 'merchant'
require_relative './modules/repository'

class MerchantRepository
  include Repository

  attr_reader :repository

  def initialize
    @repository = []
  end

end
