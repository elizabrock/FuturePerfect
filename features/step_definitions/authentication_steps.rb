Given /^I am not signed in$/ do
  destroy_user_session_path
end

Given /^I am logged in as "([^"]*)"$/ do |email|
  steps %{
    Given I am on the sign in page
    When I fill in "Email" with "#{email}"
    And I fill in "Password" with "password"
    And I press "Sign in"
    Then I should see "Welcome back!"
  }
end
