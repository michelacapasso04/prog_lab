Feature: User can choose his favourite categories 

Scenario: Choose favourite categories

Given a valid user 
When I am on the login page 
And I fill in "user_email" with "test@hotmail.com"
And I fill in "user_password" with "Tester12!"
And I press "Log in"
Then I should be on the home page

When I go to my profile page 

Given a category
Given another category
Given a third category

And I follow "Choose Your Favourite Categories"
Then I should be on Choose Your Favourite Categories page

When I check a first "categ_"
And I check also "categ_"
And I press "Choose Categories"
Then I should be on Favourite Categories page
And I should see "Pizzeria" and "Disco"
