class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :title
      t.text :description
      t.string :start_location
      t.string :end_location

      t.timestamps
    end
  end
end
