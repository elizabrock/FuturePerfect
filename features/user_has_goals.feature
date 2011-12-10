Feature: User has goals

  Background:
    Given the following users:
      | email                   |
      | me@mydomain.com         |
      | someoneelse@example.com |
    And I am logged in as "me@mydomain.com"
    And the following goals:
      | title                 | success means            | user email              |
      | world domination      | through multinational    | me@mydomain.com         |
      | xyz project           | for abc client, due 6/15 | me@mydomain.com         |
      | something embarassing | really                   | someoneelse@example.com |

  Scenario: creating a goal
    When I go to the homepage
    And I follow "New Goal"
    And I fill in "start a charitable foundation" for "Title"
    And I fill in "donating $100,000 to DMRF" for "Success Means"
    And I press "Create Goal"
    Then I should be on the homepage
    And I should see "Congratulations on your new goal!"
    And I should see "start a charitable foundation"
    When I follow "start a charitable foundation"
    Then I should see "donating $100,000 to DMRF"

  Scenario: viewing my goals
    Given I am on the homepage
    Then I should see "world domination"
    And I should see "xyz project"

  Scenario: editting goals
    Given I am on the homepage
    When I click "xyz project"
    And I click "Edit"
    And I fill in "xyz abc" for "Title"
    And I fill in "get it done" for "Success Means"
    And I press "Update Goal"
    Then I should be on the homepage
    And I should see "Your goal has been updated!"
    When I follow "xyz abc"
    Then I should see "get it done"
    And I should not see "for abc client, due 6/15"

  Scenario: can't see other's goals
    Given I am on the homepage
    Then I should not see "something embarassing"

  Scenario: can't create goals when logged out
    When I follow "Sign Out"
    And I go to the homepage
    Then I should not see "Create Goal"
