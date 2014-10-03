Given(/^I am in the prices page$/) do
  visit "/"
  expect(page).to have_content "Pull&Bear Price Manager"
end

When(/^I generate some prices$/) do
  select('Go Pro', :from => 'type') 
  select('20', :from => 'number')
  fill_in('init_time', :with => '10:00') 
  fill_in('end_time', :with => '20:00') 
  click_button('Randomize')

end

Then(/^I see the prices list$/) do
  expect(page).to have_selector("tr.enabled.go_pro", count: 20)

end

When(/^I add more prices$/) do
  select('Headphones', :from => 'type') 
  select('10', :from => 'number')
  fill_in('init_time', :with => '15:30') 
  fill_in('end_time', :with => '19:30') 
  click_button('Randomize')
  select('Ipad', :from => 'type') 
  select('1', :from => 'number')
  fill_in('init_time', :with => '15:30') 
  fill_in('end_time', :with => '16:30') 
  click_button('Randomize')
end

Then(/^I see the updated prices list$/) do
  expect(page).to have_selector("tr.enabled", count: 31)
  expect(page).to have_selector("tr.enabled.go_pro", count: 20)
  expect(page).to have_selector("tr.enabled.headphones", count: 10)
  expect(page).to have_selector("tr.enabled.ipad", count: 1)
end

When(/^I delete all prices$/) do
  click_on("Delete all")
end

Then(/^I see the empty prices list$/) do
  within(:css, "#prices_list tbody") do
    expect(page).to have_selector("tr", count: 0)
  end
end