class Category < ApplicationRecord
    has_many :types
    has_many :locations, :through => :types,  :dependent => :destroy

    has_many :fav_categories
    has_many :users, :through => :fav_categories,  :dependent => :destroy
end

#types è la tabella join location-category