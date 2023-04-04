class Location < ApplicationRecord
    has_many :types
    has_many :categories, :through => :types,  :dependent => :destroy

    belongs_to :user


    validates_presence_of :name
    validates_presence_of :street
    validates_numericality_of :lat
    validates_numericality_of :long

    def self.search_match(partecipants)
        locations = Location.all
        matching_loc = []
        index_loc = 0
        
        locations.each do |loc|
            
            user_ok=Array.new(partecipants.length, 0)
            loc.categories.each do |cat|
                index_user = 0
                partecipants.each do |part|
                    part = User.find(part)
                    if(part.categories.include?(cat))
                        user_ok[index_user]+=1
                    end
                    index_user+=1
                end
            end
            ok=true
            user_ok.each do |like|
                if like==0
                    ok=false
                    break
                end
            end
            if(ok)
                matching_loc[index_loc]=loc
                index_loc+=1
            end
        end
        return matching_loc
    end
end
