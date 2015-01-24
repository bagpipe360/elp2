Feature: Signing up for a Lesson

  As a Student,
  I want to sign up for a time slot
  so I can have a lesson with a teacher.


Scenario: Sign up for Time SLot
   Given I'm a student
   When I am browsing classes
   And I choose a timeslot
   And I save the new timeslot
   Then I should see my new time slot
   

  

