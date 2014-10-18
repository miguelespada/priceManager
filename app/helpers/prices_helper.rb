module PricesHelper

  def price_options
    options = []
    PRICES.each do |price|
      options << [pretty_print(price), price]
    end
    options
  end

  def pretty_print name
    name.gsub("_", " ").titleize
  end

  def price_stats name
   str = ""
   str += pretty_print(name)
   str += ": " 
   str += Price.where(type: name, enabled: true).count.to_s
   str += "/" 
   str += Price.where(type: name).count.to_s
  end

end
