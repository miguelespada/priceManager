DATA = YAML.load(File.open(Rails.root.join("config", "prices.yml")))["prices"]
PRICES = Array.new
NUMBERS = Hash.new
INIT_TIMES = Hash.new
END_TIMES = Hash.new
DATA.each do |d|
  tokens = d.split(' ')
  PRICES << tokens[0]
  NUMBERS[tokens[0]] = tokens[1].to_i
  INIT_TIMES[tokens[0]] = tokens[2]
  END_TIMES[tokens[0]] = tokens[3]
end