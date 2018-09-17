require_relative 'invoice'
require_relative './modules/repository'
require_relative './modules/csv_adapter'

class InvoiceRepository
  include Repository
  include CSVAdapter

  attr_reader :repository

  def initialize(path)
    @repository = []
    @class = Invoice
    get_stuff(path, @class)

  end

  def create(hash)
    create_stuff(hash, @class)
  end
end
