require 'CSV'
require_relative 'item'
require_relative './modules/repository'

class ItemRepository
  include Repository

  attr_reader :repository

  def initialize(path)
    @repository = []
    @class = Item
    get_stuff(path, @class)
  end

  def create(hash)
    create_stuff(hash, @class)
  end
  
end
