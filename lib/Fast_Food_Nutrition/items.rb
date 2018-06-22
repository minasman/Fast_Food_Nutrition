class FastFoodNutrition::Item
  attr_accessor :name, :nutrition
  @@all = []

  def initialize(name)
    @name = name
  end

  def self.all
    @@all
  end

end
