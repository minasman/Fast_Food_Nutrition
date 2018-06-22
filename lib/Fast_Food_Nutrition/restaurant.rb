class FastFoodNutrition::Restaurant
  attr_accessor :name, :url, :categories
  @@all = []
  def initialize(name, url)
    @name = name
    @url = url
    @@all << self
  end

  def self.all
    @@all
  end

  def self.find_restaurant_by_name(name)
    restaurant = ""
    self.all.each do |location|
      if name == location.name
        restaurant = location
      end
    end
    restaurant
  end

end
