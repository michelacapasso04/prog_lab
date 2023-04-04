class CreateFavLocations < ActiveRecord::Migration[5.2]
  def change
    create_table :fav_locations do |t|
      t.belongs_to :user
      t.belongs_to :location
      
      t.timestamps
    end
  end
end
