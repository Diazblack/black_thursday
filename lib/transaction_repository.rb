require_relative 'transaction'
require_relative './modules/repository'
require_relative './modules/csv_adapter'
require_relative './modules/find'

class TransactionRepository
  include Repository
  include CSVAdapter
  include Find

  attr_reader :repository

  def initialize(path)
    @repository = []
    @class = Transaction
    get_stuff(path, @class)
  end

  def create(hash)
    create_stuff(hash, @class)
  end
end
