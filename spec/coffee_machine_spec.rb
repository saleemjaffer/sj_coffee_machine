# `rspec spec/coffee_machine_spec.rb` Run this from the project root to run all the specs
require './app/coffee_machine.rb'

describe CoffeeMachine do
  # The initial config is based on the JSON provided in the problem statement: https://www.npoint.io/docs/e8cd5a9bbd1331de326a
  let(:outlets) { 3 }
  let(:inventory) {
    {
      "hot_water" => 500,
      "hot_milk" => 500,
      "ginger_syrup" => 100,
      "sugar_syrup" => 100,
      "tea_leaves_syrup" => 100
    }
  }
  let(:beverages) {
    {
      "hot_tea" => {
        "hot_water" => 200,
        "hot_milk" => 100,
        "ginger_syrup" => 10,
        "sugar_syrup" => 10,
        "tea_leaves_syrup" => 30
      },
      "hot_coffee" => {
        "hot_water" => 100,
        "ginger_syrup" => 30,
        "hot_milk" => 400,
        "sugar_syrup" => 50,
        "tea_leaves_syrup" => 30
      },
      "black_tea" => {
        "hot_water" => 300,
        "ginger_syrup" => 30,
        "sugar_syrup" => 50,
        "tea_leaves_syrup" => 30
      },
      "green_tea" => {
        "hot_water" => 100,
        "ginger_syrup" => 30,
        "sugar_syrup" => 50,
        "green_mixture" => 30
      }
    }
  }

  let(:coffee_machine) { CoffeeMachine.new(outlets, inventory, beverages) }

  context 'when there are multiple threads accessing the coffee machine concurrently' do
    let(:beverage_names) { beverages.keys[0..2] } # hot_tea, hot_coffee, black_tea

    it 'prevents race conditions' do
      threads = beverage_names.map do |beverage_name|
        Thread.new do
          coffee_machine.prepare_beverage(beverage_name)
        end
      end

      coffee_machine_outputs = threads.map(&:value)

      # One of the beverages will not be prepared since we run out of hot_water
      expect(coffee_machine_outputs.map { |beverage, _| beverage}.select(&:nil?).size).to eq 1

      # Comment out below line and run `rspec spec/coffee_machine_spec.rb:49` to see 2 different beverages
      # being chosen on running multiple times
      # puts coffee_machine_outputs.map { |beverage, _| beverage&.name }
    end
  end

  context 'test1' do # Test case for "Output 1" in the problem statement
    it 'performs the expected operations' do
      beverage_name = 'hot_tea'
      beverage, msg = coffee_machine.prepare_beverage(beverage_name)
      expect(beverage.name).to eq beverage_name
      expect(msg).to eq "#{beverage_name} is prepared"

      beverage_name = 'hot_coffee'
      beverage, msg = coffee_machine.prepare_beverage(beverage_name)
      expect(beverage.name).to eq beverage_name
      expect(msg).to eq "#{beverage_name} is prepared"

      beverage_name = 'green_tea'
      beverage, msg = coffee_machine.prepare_beverage(beverage_name)
      expect(beverage).to be_nil
      expect(msg).to eq "#{beverage_name} cannot be prepared because green_mixture is not available"

      beverage_name = 'black_tea'
      beverage,msg = coffee_machine.prepare_beverage(beverage_name)
      expect(beverage).to be_nil
      # For this specific spec the problem document mentions hot_water as 0, which is incorrect.
      expect(msg).to eq "#{beverage_name} cannot be prepared because item hot_water is 200"
    end
  end

  context 'test2' do # Test case for "Output 2" in the problem statement
    it 'performs the expected operations' do
      beverage_name = 'hot_tea'
      beverage, msg = coffee_machine.prepare_beverage(beverage_name)
      expect(beverage.name).to eq beverage_name
      expect(msg).to eq "#{beverage_name} is prepared"

      beverage_name = 'black_tea'
      beverage, msg = coffee_machine.prepare_beverage(beverage_name)
      expect(beverage.name).to eq beverage_name
      expect(msg).to eq "#{beverage_name} is prepared"

      beverage_name = 'green_tea'
      beverage, msg = coffee_machine.prepare_beverage(beverage_name)
      expect(beverage).to be_nil
      expect(msg).to eq "#{beverage_name} cannot be prepared because green_mixture is not available"

      beverage_name = 'hot_coffee'
      beverage, msg = coffee_machine.prepare_beverage(beverage_name)
      expect(beverage).to be_nil
      expect(msg).to eq "#{beverage_name} cannot be prepared because item hot_water is 0"
    end
  end

  context 'test3' do # Test case for "Output 3" in the problem statement
    it 'performs the expected operations' do
      beverage_name = 'hot_coffee'
      beverage, msg = coffee_machine.prepare_beverage(beverage_name)
      expect(beverage.name).to eq beverage_name
      expect(msg).to eq "#{beverage_name} is prepared"

      beverage_name = 'black_tea'
      beverage, msg = coffee_machine.prepare_beverage(beverage_name)
      expect(beverage.name).to eq beverage_name
      expect(msg).to eq "#{beverage_name} is prepared"

      beverage_name = 'green_tea'
      beverage, msg = coffee_machine.prepare_beverage(beverage_name)
      expect(beverage).to be_nil
      expect(msg).to eq "#{beverage_name} cannot be prepared because green_mixture is not available"

      beverage_name = 'hot_tea'
      beverage, msg = coffee_machine.prepare_beverage(beverage_name)
      expect(beverage).to be_nil
      # For this specific spec the problem document mentions hot_water as 0, which is incorrect.
      expect(msg).to eq "#{beverage_name} cannot be prepared because item hot_water is 100"
    end
  end
end
