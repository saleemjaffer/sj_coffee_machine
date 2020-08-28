require_relative './portion'

# This class maintains the inventory for the coffee machine ingredients
class IngredientInventory
  attr_reader :ingredient, :quantity

  def initialize(ingredient, quantity)
    @ingredient = ingredient
    @quantity = quantity
  end

  def sufficient_inventory?(quantity)
    true if @quantity - quantity >= 0
  end

  def consume(quantity)
    @quantity -= quantity
  end

  def refill(quantity)
    @quantity += quantity
  end
end
