require 'date'

class Event
  attr_reader :name,
              :food_trucks

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

  def overstocked_items
    overstocked = []
    total_inventory.each  do |item, values|
      if total_inventory[item][:quantity] >= 50 && total_inventory[item][:food_trucks].length >=2
        overstocked << item
      end
    end
    overstocked
  end

  def sorted_item_list
    list = []
    total_inventory.each do |item, values|
      list << item.name
    end
    list.sort
  end

  def date
    Date.today.to_s
  end

  def sell(item, amount)
    amount = amount
    if total_inventory[item].nil?
      false
    elsif total_inventory[item][:quantity] > amount
      food_trucks_that_sell(item).each do |truck|
        until "sold"
          if truck.inventory[item] > amount || truck.inventory[item] == amount
            truck.inventory[item] - amount
            return "sold"
          else
            truck.inventory[item] - amount
            truck.inventory[item]
          end
        end
      end
      true
    else
      false
    end
  end
end
