class CreateTypes < ActiveRecord::Migration[5.2]
  def change
    create_table :types do |t|
      t.belongs_to :category
      t.belongs_to :location

    end
  end
end
