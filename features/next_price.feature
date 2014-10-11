Feature: Get next price
  In order to get prices
  As remote user
  I want to be able to get and remove current price

  Scenario: There are no prices
  Given there are no prices
  When I get the next price
  Then I should receive the nothing price