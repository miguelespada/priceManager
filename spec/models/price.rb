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
      expect(Price.next.type).to eq "nothing"
      expect(Price.next.enabled).to eq false
    end

    it "returns the next availabe price" do
      my_time = Price.parse_time("11:06")
      Price.randomize("dummy_price", 1, "11:05", "11:06")
      Time.stub(:now).and_return(my_time)
      expect(Price.next.type).to eq "dummy_price"
      expect(Price.next.enabled).to eq true
    end

    it "returns nothing with future availabe prices" do
      my_time = Price.parse_time("11:00")
      Price.randomize("dummy_price", 1, "11:02", "11:05")
      Time.stub(:now).and_return(my_time)
      expect(Price.next.type).to eq "nothing"
      expect(Price.next.enabled).to eq false
    end


    it "postpones missed prices" do
      my_time = Price.parse_time("11:06")
      Price.randomize("dummy_price", 1, "11:00", "11:03")
      Time.stub(:now).and_return(my_time)
      expect(Price.next.type).to eq "nothing"
    end
  end

  describe "prices are open during 60s" do
    it "detects open price" do
      Price.randomize("dummy_price", 1, "11:04", "11:05")
      my_time = Price.parse_time("11:05")
      Time.stub(:now).and_return(my_time)
      expect(Price.next.open?).to eq true
    end

    it "detects closed price" do
      Price.randomize("dummy_price", 1, "11:04", "11:05")
      my_time = Price.parse_time("11:06")
      Time.stub(:now).and_return(my_time)
      expect(Price.next.open?).to eq false
    end
  end

  describe "reorder" do

    it "reorders a price" do
      my_time = Price.parse_time("11:30")
      Time.stub(:now).and_return(my_time)
      last = create(:price, time: Price.parse_time("11:32"))
      10.times do 
        price = create(:price, time: Price.parse_time("11:00"))
        price.reorder last.time
        expect(price.time >= Price.parse_time("11:31")).to eq true
        expect(price.time <= Price.parse_time("11:32")).to eq true
      end
    end

    it "does not reorder at the end of the day" do
      my_time = Price.parse_time("12:00")
      Time.stub(:now).and_return(my_time)
      last = create(:price, time: Price.parse_time("11:30"))
      price = create(:price, time: Price.parse_time("11:00"))
      price.reorder last.time
      expect(price.time == Price.parse_time("11:00")).to eq true
    end
  end
  
end