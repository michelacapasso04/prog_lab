class CreateFavCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :fav_categories do |t|
      t.belongs_to :category
      t.belongs_to :user

      t.timestamps
    end
  end
end
