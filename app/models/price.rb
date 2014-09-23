class Price
  include Mongoid::Document
  field :type, type: String
  field :enabled, type: Mongoid::Boolean
  field :time, type: Time

  def self.randomize number, init_time, end_time
    number.times do 
      price = Price.new
      price.type = "go pro"
      price.enabled = true
      price.time = init_time + rand(0..elapsed_seconds(init_time, end_time))
      price.save!
    end
  end

  def self.elapsed_seconds init_time, end_time
    (end_time - init_time).to_i
  end

end
