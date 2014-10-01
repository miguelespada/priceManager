FactoryGirl.define do
  factory :price do
    type  "go pro"
    time  DateTime.new(2014, 9, 22, 10, 00, 00)
    enabled true
  end
end