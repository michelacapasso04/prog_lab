require 'rails_helper'

RSpec.describe Category, type: :model do

  describe "creation and modification" do

    before(:each) { @c = Category.new(:name => "Pizzeria") }
   
    it "is valid with valid attributes" do
      expect(Category.new).to be_valid
    end

    it "sets the name of the category" do
      expect(@c.name).to eq("Pizzeria")
    end

    it "can modify the name of the category" do
      @c.name = "Disco"
      expect(@c.name).to eq("Disco")
    end 
=begin
    it "should give an error" do 
      @c.typecategory = "Pub"
      expect {@c.typecategory}.to raise_error("the name of the category is a string")
    end 
=end
  end

  describe "relation with a user (favourite categories)" do
    before(:each) { 
      @user = User.new(
      :name => "Name-Tester",
      :email => "test@gmail.com",
      :password => "PasswordTester1!",
      :password_confirmation => "PasswordTester1!",
      :roles_mask => 1)}
      before(:each) { @cat1 = Category.new(:name => "Japanese Restaurant")}
      before(:each) { @cat2 = Category.new(:name => "Chinese")}
    
    it "create fav categories for the user" do
      @user.categories.append(@cat2)
      @user.categories.append(@cat1)
      expect(@user.categories[0].name).to eq("Chinese")
      expect(@user.categories[1].name).to eq("Japanese Restaurant")
    end

  end
end
