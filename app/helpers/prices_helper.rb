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

end
