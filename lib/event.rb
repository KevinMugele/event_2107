class Event

  attr_reader :name, :food_trucks

  def initialize(name)
    @name = name
    @food_trucks = []
  end

  def add_food_truck(truck)
    @food_trucks << truck
  end

  def food_truck_names
    @food_trucks.map do |truck|
      truck.name
    end
  end

  def food_trucks_that_sell(item)
    trucks = []
    @food_trucks.each do |truck|
      truck.inventory.each do |items, amount|
        trucks << truck if items == item
      end
    end
    trucks
  end

  def total_inventory
    total_inventory = {}
    @food_trucks.each do |food_truck|
      food_truck.inventory.each do |item, amount|
        if total_inventory[item].nil?
          total_inventory[item] = {quantity: amount, food_trucks: [food_truck]}
        else
          total_inventory[item][:quantity] += amount
          total_inventory[item][:food_trucks] << food_truck
        end
      end
    end
    total_inventory
  end
end
