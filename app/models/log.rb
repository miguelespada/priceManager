class Log
  include Mongoid::Document
  include Mongoid::Timestamps

  def self.new_log
    l = Log.new
    l.save
  end
end
