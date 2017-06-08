Feature: Testing
  Scenario: Home Page
    Given I am on the homepage
    Then I should see "Laravel"
    Then I should see "Laracast"
    Then I should see "Documentation"
    Then I should see "Login"

  Scenario: Login Page
    When I go to "home"
    Then the url should match "login"
    Then print current URL
    When I fill in "email" with "stephane.guillaume71@gmail.com"
    When I fill in "password" with "0000"
    When I press "Login"
    Then I should see "Whoops"

  Scenario: Register Page
    When I go to "register"
    Then the url should match "register"
    Then print current URL
    When I fill in "name" with "steven"
    When I fill in "email" with "stephane.guillaume71@gmail.com"
    When I fill in "password" with "0000"
    When I fill in "password-confirm" with "0000"
    When I press "Register"
    Then I should see "Whoops"
