require 'spec_helper'

describe "Price" do

  describe "randomize" do

    it "generates the correct number" do
      Price.randomize(10, "10:00", "12:00")
      expect(Price.where(enabled: true).count).to eq 10
    end


    it "generates prices on time limits" do
      100.times do
        Price.randomize(10, "10:00", "12:00")
        expect(Price.first.time >= Price.parse_time("10:00")).to eq true
        expect(Price.last.time <= Price.parse_time("12:00")).to eq true
      end
    end

  end
  
end