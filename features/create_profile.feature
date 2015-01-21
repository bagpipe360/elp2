Feature: Creating Profile

  As a New User,
  I want to create an account for El-P,
  so I can login to to the site.


Scenario: Creating a Profile
   Given I'm a new user
   When I fill in my profile
   And I view my profile
   Then I should see my information

