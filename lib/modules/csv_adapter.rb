require 'CSV'

module CSVAdapter

  def get_stuff(path, object_class)
    CSV.foreach(path, headers: true, header_converters: :symbol) do |row_hash|
      @repository << object_class.new(row_hash)
    end
  end
end
