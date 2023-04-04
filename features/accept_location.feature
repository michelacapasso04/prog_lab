Feature: Accept new Locations
    I want to accept the new proposed Locations

    Scenario: New Locations to Accept
        
        Given a valid admin
        When I am on the login page 
        And I fill in "user_email" with "test@gmail.com" 
        And I fill in "user_password" with "Test123!" 
        And I press "Log in" 
        Then I should be on admin homepage

        Given I am on admin homepage
        And a valid pending location
        When I follow "Accept"
        Then I should be on the accept page

        When I checkLoc "accepted_"
        And I press "Confirm"
        Then I should be on locations
        