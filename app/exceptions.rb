class InsufficientQuantityException < StandardError
  def initialize(hsh)
    msg = "#{hsh[:beverage].name} cannot be prepared because item #{hsh[:ingredient_inventory].ingredient.name} is #{hsh[:ingredient_inventory].quantity}"
    super(msg)
  end
end

class IngredientNotAvailableException < StandardError
  def initialize(hsh)
    msg = "#{hsh[:beverage].name} cannot be prepared because #{hsh[:ingredient].name} is not available"
    super(msg)
  end
end
