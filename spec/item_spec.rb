# frozen_string_literal: true

require './lib/item'
require './lib/food_truck'

RSpec.describe Item do
  it 'exists' do
    item1 = Item.new({ name: 'Peach Pie (Slice)', price: '$3.75' })

    expect(item1).to be_a Item
  end

  it 'has attributes' do
    item1 = Item.new({ name: 'Peach Pie (Slice)', price: '$3.75' })
    item2 = Item.new({ name: 'Apple Pie (Slice)', price: '$2.50' })

    expect(item1.name).to eq('Peach Pie (Slice)')
    expect(item1.price).to eq(3.75)
    expect(item2.name).to eq('Apple Pie (Slice)')
    expect(item2.price).to eq(2.50)
  end

  it 'checks the potential_revenue' do
    event = Event.new('South Pearl Street Farmers Market')
    food_truck1 = FoodTruck.new('Rocky Mountain Pies')
    item1 = Item.new({ name: 'Peach Pie (Slice)', price: '$3.75' })
    item2 = Item.new({ name: 'Apple Pie (Slice)', price: '$2.50' })
    item3 = Item.new({ name: 'Peach-Raspberry Nice Cream', price: '$5.30' })
    item4 = Item.new({ name: 'Banana Nice Cream', price: '$4.25' })
    food_truck1.stock(item1, 35)
    food_truck1.stock(item2, 7)
    food_truck2 = FoodTruck.new('Ba-Nom-a-Nom')
    food_truck2.stock(item4, 50)
    food_truck2.stock(item3, 25)
    food_truck3 = FoodTruck.new('Palisade Peach Shack')
    food_truck3.stock(item1, 65)
    event.add_food_truck(food_truck1)
    event.add_food_truck(food_truck2)
    event.add_food_truck(food_truck3)

    expect(food_truck1.potential_revenue).to eq(148.75)
    expect(food_truck2.potential_revenue).to eq(345.00)
    expect(food_truck3.potential_revenue).to eq(243.75)
  end
end
