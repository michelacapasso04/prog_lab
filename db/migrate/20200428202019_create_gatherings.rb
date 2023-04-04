class CreateGatherings < ActiveRecord::Migration[5.2]
  def change
    create_table :gatherings do |t|
      t.datetime :date
      t.belongs_to :location

      t.timestamps
    end
  end
end
