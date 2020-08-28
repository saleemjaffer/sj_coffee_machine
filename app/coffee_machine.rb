require_relative './beverage'
require_relative './exceptions'
require_relative './ingredient'
require_relative './ingredient_inventory'

class CoffeeMachine
  def initialize(outlets, inventory, beverages)
    @mutex = Mutex.new
    @outlets = outlets

    @inventory = inventory.map do |ingredient_name, quantity|
      ingredient = Ingredient.new(ingredient_name)
      [ingredient, IngredientInventory.new(ingredient, quantity)]
    end.to_h

    @beverages = beverages.map do |name, portions|
      portions = portions.map do |ingredient_name, quantity|
        Portion.new(Ingredient.new(ingredient_name), quantity)
      end
      beverage = Beverage.new(name, portions)
      [beverage.name, beverage]
    end.to_h
  end

  def prepare_beverage(beverage_name)
    begin
      beverage = @beverages[beverage_name]
      @mutex.synchronize { consume_ingredients(beverage) }
      msg =  "#{beverage.name} is prepared"
    rescue IngredientNotAvailableException, InsufficientQuantityException => e
      beverage = nil
      msg =  e.message
    end

    [beverage, msg]
  end

  def consume_ingredients(beverage)
    available_ingredients = @inventory.keys
    required_ingredients = beverage.portions.map(&:ingredient)

    # Check whether all ingredients required for beverage are present in inventory
    unless (unavailable_ingredients = required_ingredients - available_ingredients).empty?
      raise IngredientNotAvailableException.new({ beverage: beverage, ingredient: unavailable_ingredients[0] })
    end

    # Check whether the quantity required for each potion in the beverage is available in inventory
    beverage.portions.each do |portion|
      ingredient_inventory = @inventory[portion.ingredient]
      unless ingredient_inventory.sufficient_inventory?(portion.quantity)
        raise InsufficientQuantityException.new({ beverage: beverage, ingredient_inventory: ingredient_inventory })
      end
    end

    beverage.portions.each do |portion|
      ingredient_inventory = @inventory[portion.ingredient]
      ingredient_inventory.consume(portion.quantity)
    end
  end
end
