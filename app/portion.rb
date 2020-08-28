# A portion is the quantity required of a ingredient as a part of the beverage
class Portion
  attr_reader :ingredient, :quantity

  def initialize(ingredient, quantity)
    @ingredient = ingredient
    @quantity = quantity
  end
end
