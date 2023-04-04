Feature: Matching Location
 
    Scenario: Generate Matching Location
        Given a valid user
        When I am on the login page
        And I fill in "user_email" with "test@hotmail.com"
        And I fill in "user_password" with "Tester12!"
        And I press "Log in"
        Then I should be on the home page

        When I have added a friend
        Given a valid location
        When I am on the new gathering page
        And I check "partecipants_"
        And I press "Generate matching locations"
        Then I should be on the matching locations page
        And I should see "testloc"
        And I should not see "testlocwrong"

        
   
        

