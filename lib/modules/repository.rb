require 'CSV'
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
      single_data.name.downcase.include?(partial_name.downcase)
    end
  end

  def create_stuff(hash, object_class)
    new_id = @repository.last.id + 1
    hash[:id] = new_id
    @repository << object_class.new(hash)
  end

  def delete(id)
    @repository.delete(find_by_id(id))
  end

  def update(id_to_find, hash)

    single_data = find_by_id(id_to_find)
    single_data.change_attributes(hash) if single_data
  end
end
