class Price
  include Mongoid::Document
  field :type, type: String
  field :enabled, type: Mongoid::Boolean
  field :time, type: DateTime

  def self.randomize number
    number.times do 
      price = Price.new
      price.type = "go pro"
      price.enabled = true
      price.time = DateTime.new(2014, 9, 22,  rand(10..20), rand(0..59), rand(0..59))
      price.save!
    end
  end
end
