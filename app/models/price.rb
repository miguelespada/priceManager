class Price
  include Mongoid::Document

  default_scope ->{ asc(:time) }

  field :type, type: String
  field :enabled, type: Mongoid::Boolean
  field :time, type: Time


  def self.randomize number, init_time, end_time
    init_time = parse_time(init_time)
    end_time  = parse_time(end_time)

    number.times do 
      FactoryGirl.create(:price, time: init_time + rand(0..elapsed_seconds(init_time, end_time)))
    end
  end

  def self.elapsed_seconds init_time, end_time
    (end_time - init_time).to_i
  end


  def self.parse_time time_string
    init_hour = time_string.split(':')[0].to_i
    init_minute = time_string.split(':')[1].to_i
    Time.now.change({ hour: init_hour, min: init_minute, sec: 0 })
  end

end
