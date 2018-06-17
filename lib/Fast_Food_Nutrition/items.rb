class Item
  attr_accessor :name
  @@all = []

  def initialize(name)
    @name = name
  end

  def self.all
    @@all
  end

  def nutrition=(nutrition_array)
    @nutrition = nutrition_array
  end

  def nutrition
    @nutrition
  end

end
