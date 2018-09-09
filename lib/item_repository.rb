require_relative 'item'
require_relative './modules/repository'

class ItemRepository
  include Repository

  attr_reader :repository

  def initialize
    @repository = []
  end

end
