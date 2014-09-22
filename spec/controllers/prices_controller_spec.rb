require 'spec_helper'

describe PricesController do
  describe "GET #index" do
    it "responds successfully" do
      get :index
      expect(response).to be_success
    end
  end

  describe "GET #next_price" do
    it "returns json" do
      get :next_price, {format: 'json'}
      expect(response).to be_success
    end

    before do
      p = Price.new
      p.type = "go pro"
      p.enabled = true
      p.time = DateTime.new(2014, 9, 22, 10, 00, 00)
      p.save 

      p = Price.new
      p.type = "gafas de sol"
      p.enabled = true
      p.time = DateTime.new(2014, 9, 22, 8, 00, 00)
      p.save 
    end

    it "gets correct price" do
      my_clock =  DateTime.new(2014, 9, 22, 9, 59, 59)
      DateTime.stub(:now).and_return(my_clock)
      get :next_price, {format: 'json'}
      assigns(:price).should eq nil
    end

    it "gets correct price" do
      my_clock =  DateTime.new(2014, 9, 22, 10, 00, 00)
      DateTime.stub(:now).and_return(my_clock)
      get :next_price, {format: 'json'}
      assigns(:price).type.should eq "go pro"
    end


    it "gets correct price" do
      my_clock =  DateTime.new(2014, 9, 22, 20, 00, 00)
      DateTime.stub(:now).and_return(my_clock)
      get :next_price, {format: 'json'}
      assigns(:price).type.should eq "go pro"
    end
  end
end