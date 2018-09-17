require 'CSV'
module Repository

  def inspect
    "#<#{self.class} #{@repository.size} rows>"
  end

  def all
    @repository
  end

  def find_by_id(id_to_find)
    @repository.find do |single_data|
      single_data.id == id_to_find
    end
  end

  def find_all_by_merchant_id(id_to_find)
    @repository.find_all do |single_data|
      single_data.merchant_id == id_to_find
    end
  end

  def find_all_by_customer_id(id_to_find)
    @repository.find_all do |single_data|
      single_data.customer_id == id_to_find
    end
  end

  def find_all_by_status(string)
    @repository.find_all do |single_data|
      single_data.status.downcase == string.downcase.to_sym
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
    single_data.change_attributes(hash) if single_data != nil
  end
  
  def find_all_by_price_greater_or_lesser(money, key) # key is a boolean
    @repository.find_all do |item|
      if !key
        item.unit_price < money
      else
        item.unit_price >= money
      end
    end
  end

  def number_of_items_by_merchant
    @merchants.repository.map do |merchant|
      items = @items.find_all_by_merchant_id(merchant.id)
      items.length
    end
  end

  def find_all_by_day_created_at
    hash_days_of_week = {
      0 => "Sunday",
      1 => "Monday",
      2 => "Tuesday",
      3 => "Wednesday",
      4 => "Thursday",
      5 => "Friday",
      6 => "Saturday"
    }
    @repository.inject(Hash.new(0)) do |hash, stuff|
      day_integer = hash_days_of_week[stuff.created_at.wday]
      hash[day_integer] += 1
      hash
    end
  end
end
