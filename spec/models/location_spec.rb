require 'rails_helper'

RSpec.describe Location, :type => :model do
    location = FactoryBot.create(:location_pending)
    describe "a new location" do
        it "is valid with valid attributes" do
            expect(location).to be_valid
        end
        it "is not valid without a name" do
            location.name = nil 
            expect(location).to_not be_valid
        end 
        it "is not valid without a street" do
            location.street = nil 
            expect(location).to_not be_valid
        end
        it "is not valid without a longitude" do
            location.long = nil 
            expect(location).to_not be_valid 
        end
        it "is not valid without a latitude" do 
            location.lat = nil 
            expect(location).to_not be_valid
        end
    end
    describe "search_match" do
        before(:each) do
            @categories=[]
            @users=[]
            @locations=[]

            @categories[0]=create(:category,name: "Pizzeria")     #0
            @categories[1]=create(:category,name: "Pub")          #1
            @categories[2]=create(:category,name: "Disco")        #2
            @categories[3]=create(:category,name: "CocktailBar")  #3
            @categories[4]=create(:category,name: "Rooftop")      #4
            @categories[5]=create(:category,name: "Capybara")      #5
            @categories[6]=create(:category,name: "RottenPot")      #6

            app=[]
            app<<@categories[0]<<@categories[1]
            user1=create(:user_with_categories, categories:app) # Pizzeria, Pub
            app=[]
            app<<@categories[5]<<@categories[6]
            user2=create(:user_with_categories, categories:app) # Capybara RottenPot
            user3=create(:user_with_categories, categories:app) # Capybara RottenPot
            app=[]
            app<<@categories[2]<<@categories[3]
            user4=create(:user_with_categories, categories:app) # Disco CocktailBar

            @users << user1.id
            @users << user2.id
            @users << user3.id
            @users << user4.id

            allow(User).to receive_message_chain(:find).with(user1.id).and_return(user1)
            allow(User).to receive_message_chain(:find).with(user2.id).and_return(user2)
            allow(User).to receive_message_chain(:find).with(user3.id).and_return(user3)
            allow(User).to receive_message_chain(:find).with(user4.id).and_return(user4)
            allow(Location).to receive_message_chain(:all).and_return(@locations)
        end
        
        it "returns valid matching location" do
            app=[]
            app<<@categories[0]<<@categories[3]<<@categories[5]
            @locations[0]= create(:location_with_categories, name:"BarPub", categories: app) # Pizzeria CocktailBar Capybara OK
            app=[]
            app<<@categories[5]<<@categories[6]
            @locations[1]= create(:location_with_categories, name:"La notte brava", categories:app ) # Capybara ROttenPot NOK
            app=[]
            app<<@categories[1]<<@categories[2]
            @locations[2]= create(:location_with_categories, name:"Top roof", categories:app ) #Pub Disco NOK
            app=[]
            app<<@categories[1]<<@categories[2]<<@categories[6]
            @locations[3]= create(:location_with_categories, name:"Rails on Ruby", categories: app) #Pub Disco RottenPot OK
            app=[]
            app<<@categories[3]<<@categories[4]
            @locations[4]= create(:location_with_categories, name:"Tondo tondo", categories:app ) #CocktailBar Rooftop NOK

            result=Location.search_match(@users)
            expect(result[0]).to eql(@locations[0])
            expect(result[1]).to eql(@locations[3])
        end
        it "returns empty matching location" do
            app=[]
            app<<@categories[0]<<@categories[3]
            @locations[0]= create(:location_with_categories, name:"BarPub", categories: app) # Pizzeria CocktailBar NOK
            app=[]
            app<<@categories[5]<<@categories[6]
            @locations[1]= create(:location_with_categories, name:"La notte brava", categories:app ) # Capybara ROttenPot NOK
            app=[]
            app<<@categories[4]<<@categories[5]<<@categories[6]
            @locations[2]= create(:location_with_categories, name:"Top roof", categories:app ) #Rooftop Capybara Rottenpot NOK
            app=[]
            app<<@categories[2]<<@categories[6]
            @locations[3]= create(:location_with_categories, name:"Rails on Ruby", categories: app) #Disco RottenPot NOK
            app=[]
            app<<@categories[3]<<@categories[4]
            @locations[4]= create(:location_with_categories, name:"Tondo tondo", categories:app ) #CocktailBar Rooftop NOK

            result=Location.search_match(@users)
            expect(result).to eql([])
        end
    end
end
