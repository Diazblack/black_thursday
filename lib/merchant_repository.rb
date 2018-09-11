require_relative 'merchant'
require_relative './modules/repository'
require_relative './modules/csv_adapter'

class MerchantRepository
  include Repository
  include CSVAdapter

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
