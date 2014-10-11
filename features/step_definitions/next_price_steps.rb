Given(/^there are no prices$/) do
end

When(/^I get the next price$/) do
	visit "prices/next_price.json"
end

Then(/^I should receive the nothing price$/) do
	expect(page).to have_content("nothing")
end