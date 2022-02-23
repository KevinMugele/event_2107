# frozen_string_literal: true

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
    @food_trucks.map(&:name)
  end

  def food_trucks_that_sell(item)
    @food_trucks.find_all do |truck|
      truck.check_stock(item).positive?
    end
  end

  def total_inventory
    total_inventory = {}
    @food_trucks.each do |food_truck|
      food_truck.inventory.each do |item, amount|
        if total_inventory[item].nil?
          total_inventory[item] = { quantity: amount, food_trucks: [food_truck] }
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
    total_inventory.each do |item, _values|
      overstocked << item if total_inventory[item][:quantity] >= 50 && total_inventory[item][:food_trucks].length >= 2
    end
    overstocked
  end

  def sorted_item_list
    list = []
    total_inventory.each do |item, _values|
      list << item.name
    end
    list.uniq.sort
  end

  def date
    Date.today.to_s
  end

  def sell(item, amount)
    if total_inventory[item].nil?
      false
    elsif total_inventory[item][:quantity] > amount
      food_trucks_that_sell(item).each do |truck|
        until 'sold'
          truck.inventory[item] - amount
          if truck.inventory[item] > amount || truck.inventory[item] == amount
            return 'sold'
          else
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
