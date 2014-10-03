Feature: Price management
  In order to manage prices
  As user
  I want to generate the prices

  Background: 
  Given I am in the prices page
  When I generate some prices

  Scenario: Generate prices
  Then I see the prices list

  Scenario: Add more prices
  When I add more prices
  Then I see the updated prices list
