Feature: User makes progress on goals
  Background:
    Given the following user:
      | email | me@mydomain.com |
    And that user has the following goal:
      | title         | abc project           |
      | success means | finishing by the 15th |
    And I am logged in as "me@mydomain.com"
    And I am on the homepage

  Scenario: Making the first progress
    When I follow "abc project"
    And I fill in "found a designer" for "Task Accomplished"
    And I fill in "get final approval from client" for "Next Step"
    And I press "Record Progress"
    Then I should see "Woohoo! You made progress!"
    And I should be on the goal page for "abc project"
    And I should see "Next Step: get final approval from client"

  Scenario: Error making progress
    When I follow "abc project"
    And I press "Record Progress"
    Then I should see "Task Accomplished*can't be blank"
    And I should see "Next Step*can't be blank"
    And I should see "abc project"

  Scenario: Making additional progress
    Given that goal has the following progresses:
      | task accomplished   | next step     |
      | sent proposal       | get signature |
      | got proposal signed | find designer |
    And I am on the homepage
    When I follow "abc project"
    Then I should see "Next Step: find designer"
    When I fill in "found a designer" for "Task Accomplished"
    And I fill in "get final approval from client" for "Next Step"
    And I press "Record Progress"
    Then I should see "Woohoo! You made progress!"
    And I should be on the goal page for "abc project"
    And I should see "Next Step: get final approval from client"
    And I should see "The last time you made progress was less than a minute ago"

  Scenario: Viewing previous progress
    Given that goal has the following progresses:
      | task accomplished   | next step     |
      | sent proposal       | get signature |
      | got proposal signed | find designer |
    And I am on the homepage
    When I follow "abc project"
    Then I should see "Next Step: find designer"
    And I should see "Previously you:"
    And I should see the following list:
      | sent proposal       |
      | got proposal signed |
    And I should see "The last time you made progress was less than a minute ago"

  Scenario: Viewing previous progress (aging)
    Given that goal has the following progresses:
      | task accomplished   | next step     |
      | sent proposal       | get signature |
      | got proposal signed | find designer |
    And two days have passed
    And I am on the homepage
    When I follow "abc project"
    Then I should see "Next Step: find designer"
    And I should see "The last time you made progress was 2 days ago"
