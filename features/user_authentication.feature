Feature: User signs in

  Background:
    Given the following user:
      | email    | user@email.com |
      | password | password       |

  Scenario: Successful sign in
    Given I am on the sign in page
    When I fill in "Email" with "user@email.com"
    And I fill in "Password" with "password"
    And I press "Sign in"
    Then I should see "Welcome back!"

  Scenario: Unsuccessful sign in
    Given I am on the sign in page
    When I fill in "Email" with "user@email.com"
    And I fill in "Password" with "ohdeariforgotmypassword"
    And I press "Sign in"
    Then I should see "Invalid email or password."

  Scenario: Sign out
    Given I am logged in as "user@email.com"
    When I click "Sign Out"
    Then I should see "Sign In"

  Scenario: Successful Sign Up
    Given I am not signed in
    When I go to the homepage
    And I click "Sign Up"
    And I fill in "Email" with "eliza@example.com"
    And I fill in "Password" with "password"
    And I press "Sign up"
    Then I should see "Welcome! You have signed up successfully."
    And I should see "Sign Out"

  Scenario: Unsuccessful Sign Up (password)
    Given I am not signed in
    When I go to the homepage
    And I click "Sign Up"
    And I fill in "Email" with "eliza@example.com"
    And I fill in "Password" with ""
    And I press "Sign up"
    Then I should see the error message "Password can't be blank"
    And I should not see "Welcome! You have signed up successfully."
    And I should not see "Sign Out"

  Scenario: Unsuccessful Sign Up (email)
    Given I am not signed in
    When I go to the homepage
    And I click "Sign Up"
    And I fill in "Email" with ""
    And I fill in "Password" with "password"
    And I press "Sign up"
    Then I should see the error message "Email can't be blank"
    And I should not see "Welcome! You have signed up successfully."
    And I should not see "Sign Out"

