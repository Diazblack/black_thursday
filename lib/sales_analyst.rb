require_relative 'sales_engine'
require_relative './modules/mathematics'

class SalesAnalyst
  include Mathematics
  attr_reader :engine

  def initialize(engine)
    @engine = engine
  end

end
