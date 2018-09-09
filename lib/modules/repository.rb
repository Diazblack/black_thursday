module Repository

  def all
    @repository.each do |single_data|
      single_data
    end

  def find_by_id(id_to_find)
    @repository.find do |single_data|
      @repsitory.id == id_to_find
    end
  end

  def find_by_name(name_to_find)
    @repository.find do |single_data|
      @repsitory.name == name_to_find
    end
  end

#mierda tengo que ingeniarme como conseguir un valor parcial
  def find_all_by_name(all_name)
    @repository.find do |single_data|
      @repsitory.name == name_to_find
    end
  end
end
