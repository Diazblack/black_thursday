require_relative 'invoice_item'
require_relative './modules/repository'
require_relative './modules/csv_adapter'
require_relative './modules/find'

class InvoiceItemRepository
  include Repository
  include CSVAdapter
  include Find
  
  attr_reader :repository

  def initialize(path)
    @repository = []
    @class = InvoiceItem
    get_stuff(path, @class)
  end

  def create(hash)
    create_stuff(hash, @class)
  end
end
