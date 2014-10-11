FactoryGirl.define do
  factory :price do
    type  "Unknown"
    time  Time.now
    enabled true
    trait :nothing do
    	type "nothing"
    	enabled false
  	end
  end
end