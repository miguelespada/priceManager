Feature: Get next price
  In order to get prices
  As remote user
  I want to be able to get and disable prices

  Scenario: There are no prices
    Given there are no prices
    When I get the next price
    Then I should receive the nothing price

  @open
  Scenario: Open prices
    Given there are some prices
    When a price is open
    Then I should see the price is enabled and open

  @disable
  Scenario: disable price
    Given there are some prices
    And I disable a price
    Then I should see that the price was disabled