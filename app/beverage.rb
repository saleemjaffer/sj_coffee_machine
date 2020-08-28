class Beverage
  attr_reader :name, :portions

  def initialize(name, portions)
    @name = name
    @portions = portions # Every beverage is made up of portions
  end
end
