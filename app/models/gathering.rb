class Gathering < ApplicationRecord
    belongs_to :location
    
    has_many :groups
    has_many :users, :through => :groups

    

    
end
