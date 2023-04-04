require 'rails_helper.rb'


	RSpec.describe LocationsController, :type => :controller do
		describe "POST locations#accept_locations" do
			before(:each) do
				@request.env["devise.mapping"] = Devise.mappings[:user]
				admin = FactoryBot.create(:admin)
				sign_in admin
				allow(Location).to receive_message_chain(:search_match).and_return("test_location")
				#controller.stub(:search_match).and_return(["test_location"]) DEPRECATED
			end

			context "when the user is an admin" do
					it "shows the pending locations" do
						get :accept
						expect(response.status).to  eql(200)
					end
					
					it "and deny all" do
						post "accept_locations", params: {accepted: []}
						expect(response.status).to eq (302)
					end
					it "and accept the selected ones" do
						location = FactoryBot.create(:location_pending)
						post :accept_locations, params: {:accepted => [[location.id]]}
					 	expect(response.status).to eq (302)
					end
			end
		end
	
	end


