require 'rails_helper'

RSpec.describe CategoriesController, :type => :controller do
    describe "Categories Management" do
        before(:each) do
            @request.env["devise.mapping"] = Devise.mappings[:user]
            user = FactoryBot.create(:user)
            sign_in user
            #allow(Location).to receive_message_chain(:search_match).and_return("test_location")
            #controller.stub(:search_match).and_return(["test_location"]) DEPRECATED
            #render_views
        end

            it "GET categories#index -> should list titles of all categories" do 
                get :index 
                expect(response).to render_template(:index)
            end 

            
            it "GET categories#new -> only the admin is able to create a new category" do                     
                admin = FactoryBot.create(:admin)
                sign_in admin
                get :new
                expect(response).to render_template(:new)
            end

            context "having valid params" do 
                valid_params = {:categories=> {:name => "ciao"}}
                it "POST categories#create -> admin create a new category" do 
                    admin = FactoryBot.create(:admin)
                    sign_in admin
                    post :create, :params => valid_params
                    expect(response).to redirect_to(categories_path)    

                end
            end

            context "not checking category" do
                valid_params = {:checkbox => ""}
                it "schould returns the array of favourites categories empty" do 
                    post :create_fav_categories,:params => valid_params                    
                    expect(response.status).to eql(302)
                    expect(flash[:alert]).to match(/Choose some favourite categories!!*/)
                end 
            end
    end
end

