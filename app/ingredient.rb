class Ingredient
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def eql?(ingredient)
    @name == ingredient.name
  end

  def hash
    @name.hash
  end
end
