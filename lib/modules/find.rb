module Find

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

  def find_all_by_method(number, method)
    @repository.find_all do |single_data|
      single_data.send(method) == number
    end
  end

  def find_all_by_string(partial_string, method)
    @repository.find_all do |single_data|
      single_data.send(method).downcase.include?(partial_string.downcase)
    end
  end

  def find_all_by_merchant_id(id_to_find)
    find_all_by_method(id_to_find, "merchant_id")
  end

  def find_all_by_customer_id(id_to_find)
    find_all_by_method(id_to_find, "customer_id")
  end

  def find_all_by_item_id(id_to_find)
    find_all_by_method(id_to_find, "item_id")
  end

  def find_all_by_credit_card_number(number)
    find_all_by_method(number, "credit_card_number")
  end

  def find_all_by_invoice_id(id_to_find)
    find_all_by_method(id_to_find, "invoice_id")
  end

  def find_all_by_status(string)
    find_all_by_method(string.downcase.to_sym,"status")
  end

  def find_all_by_result(result_to_find)
    find_all_by_method(result_to_find,"result")
  end

  def find_all_by_name(partial_name)
    find_all_by_string(partial_name,"name")
  end

  def find_all_by_first_name(partial_name)
    find_all_by_string(partial_name, "first_name")
  end

  def find_all_by_last_name(partial_name)
    find_all_by_string(partial_name, "last_name")
  end
end
