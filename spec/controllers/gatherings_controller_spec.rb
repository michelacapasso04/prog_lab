require "rails_helper"
RSpec.describe GatheringsController, :type => :controller do
    describe "POST 'generate_locations'" do
        before(:each) do
            @request.env["devise.mapping"] = Devise.mappings[:user]
            user = FactoryBot.create(:user)
            sign_in user
            allow(Location).to receive_message_chain(:search_match).and_return("test_location")
            #controller.stub(:search_match).and_return(["test_location"]) DEPRECATED
        end

        context "having valid params" do
            valid_params = {:partecipants =>  [1,2],:date=> Date.today}
            it "should return the matching locations" do
                post 'generate_locations',:params => valid_params
                expect(response.status).to  eql(200)
            end
        end
        context "not having date parameters" do
            invalid_params = {:partecipants =>  [1,2]}
            it "should redirect to new gatherings path" do
                post 'generate_locations',:params => invalid_params
                expect(response.status).to  eql(302) #redirected
                expect(flash[:alert]).to match(/Should select the date.*/)
            end
        end
        context "not having partecipants parameters" do
            invalid_params = {:date=> Date.today}
            it "should redirect to new gatherings path" do
                post 'generate_locations',:params => invalid_params
                expect(response.status).to  eql(302) #redirected
                expect(flash[:alert]).to match(/Should select at least one friend.*/)
            end
        end
    end
end

