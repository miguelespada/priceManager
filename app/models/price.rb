class Price
  include Mongoid::Document

  default_scope ->{ asc(:time) }
  scope :enabled, ->{where(enabled: true)}
  scope :disabled, ->{where(enabled: false)}

  field :type, type: String
  field :enabled, type: Mongoid::Boolean
  field :time, type: Time


  def self.randomize type, number, init_time, end_time
    init_time = parse_time(init_time)
    end_time  = parse_time(end_time)

    number.times do 
      FactoryGirl.create(:price, type: type, time: init_time + rand(0..elapsed_seconds(init_time, end_time)))
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

  def self.next
    reorder_prices
    enabled.first && enabled.first.open? ? enabled.first : FactoryGirl.build(:price, :nothing)
  end

  def self.reorder_prices
    enabled.each do |price|
      price.reorder enabled.last.time
    end
  end

  def reorder last_time
    if missed?
      self.time = Time.now + rand(60..Price.elapsed_seconds(Time.now, last_time))
      self.save! 
    end
  rescue
  end

  def enabled?
    enabled
  end

  def passed?
    (Time.now - time) >= 0
  end
  
  def open?
    recent? && passed?
  end

  def recent?
    (Time.now - time) < 60
  end 

  def missed?
    !open? and passed?
  end

  def editable?
    !open? and enabled?
  end
end
