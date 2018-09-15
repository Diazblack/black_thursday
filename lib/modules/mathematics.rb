require 'Time'
require "bigdecimal"
require "bigdecimal/util"

module Mathematics

  def transform_to_big_decimal(data)
    if data.class == String
      string = data.insert( - 3, ".")
      BigDecimal.new(string)
    elsif data.class == Float || data.class == Integer
      data.to_d
    else
      data
    end
  end

  def transform_to_time(data)
    if data.class != Time
      Time.parse(data)
    else
      data
    end
  end

  def standard_diviation_array(array)
    sum_all_integers = sum_of_integers(array)
    average = average_number(sum_all_integers, array.length)
    subtract = subtract_index(array, average)
    sum_square_numbers = sum_of_integers(square_numbers(subtract))
    standart = sum_square_numbers / array.length
    Math.sqrt(standart).round(2)
  end

  def sum_of_integers(array)
      array.inject(0) do |sum, item|
        sum += item
      end
  end

  def average_number(sum, length)
     (sum.to_f / length.to_f).round(2)
  end

  def subtract_index(array, average)
    array.map do |index|
      (index - average).round(2)
    end
  end

  def square_numbers(array)
    array.map do |square|
      (square ** 2).round(2)
    end
  end
end
