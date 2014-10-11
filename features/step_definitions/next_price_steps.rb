Given(/^there are no prices$/) do
end

When(/^I get the next price$/) do
	visit "prices/next.json"
end

Then(/^I should receive the nothing price$/) do
	expect(page).to have_content("nothing")
end

Given(/^there are some prices$/) do
	@sample_price = FactoryGirl.create(:price, type: "go_pro")
end

Given(/^I disable a price$/) do
	visit disable_path(@sample_price)
end

Then(/^I should see that the price was disabled$/) do
	expect(page).to have_content("successfully")
  expect(page).to have_selector("tr#price_#{@sample_price.id}.disabled")
end