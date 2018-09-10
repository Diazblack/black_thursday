module Repository

  def all
    @repository
  end

  def find_by_id(id_to_find)
    @repository.find do |single_data|
      single_data.id == id_to_find
    end
  end

  def find_by_name(name_to_find)
    @repository.find do |single_data|
      single_data.name.downcase == name_to_find.downcase
    end
  end

  def find_all_by_name(partial_name)
    @repository.find_all do |single_data|
      single_data.name.downcase.start_with?(partial_name.downcase)
    end
  end

  def delete(id)
    @repository.delete(find_by_id(id))
  end

  def get_date
    Date.today.strftime("%Y-%m-%d")
  end
end
