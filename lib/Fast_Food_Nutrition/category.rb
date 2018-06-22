class Category
  attr_accessor :name, :items
  @@all = []

  def initialize(name)
    @name = name
    @@all << self
  end

  def self.all
    @@all
  end

  # def items=(item_array)
  #   @items = item_array
  # end
  #
  # def items
  #   @items
  # end

end
