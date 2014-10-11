require 'spec_helper'

describe "Price" do

  describe "randomize" do

    it "generates the correct number" do
      Price.randomize("dummy_price", 10, "10:00", "12:00")
      expect(Price.where(enabled: true).count).to eq 10
    end


    it "generates prices on time limits" do
      10.times do
        Price.randomize("dummy_price", 10, "10:00", "12:00")
        expect(Price.first.time >= Price.parse_time("10:00")).to eq true
        expect(Price.last.time <= Price.parse_time("12:00")).to eq true
      end
    end
  end

  describe "next price" do
    it "returns nothing if no prices" do
      expect(Price.next_price.type).to eq "nothing"
      expect(Price.next_price.enabled).to eq false
    end

    it "returns the next availabe price" do
      my_time = Price.parse_time("11:06")
      Price.randomize("dummy_price", 1, "11:00", "11:05")
      Time.stub(:now).and_return(my_time)
      expect(Price.next_price.type).to eq "dummy_price"
      expect(Price.next_price.enabled).to eq true
    end

    it "returns nothing with future availabe prices" do
      my_time = Price.parse_time("11:00")
      Price.randomize("dummy_price", 1, "11:02", "11:05")
      Time.stub(:now).and_return(my_time)
      expect(Price.next_price.type).to eq "nothing"
      expect(Price.next_price.enabled).to eq false
    end


    it "returns the correct available" do
      my_time = Price.parse_time("11:06")
      Price.randomize("dummy_price_2", 1, "11:04", "11:05")
      Price.randomize("dummy_price", 1, "11:00", "11:03")
      Time.stub(:now).and_return(my_time)
      expect(Price.next_price.type).to eq "dummy_price"
      expect(Price.next_price.enabled).to eq true
    end
  end
  
end