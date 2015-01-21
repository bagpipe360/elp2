Feature: Creating Schedule

  As a Teacher,
  I want to create an want to create a Time Slot
  so I can track my classes.


Scenario: Creating a Time Slot
   Given I'm a teacher
   When I am on my time slots page
   And I fill in my information for a timeslot
   And I save the new timeslot
   Then I should see my new time slot
   

  

