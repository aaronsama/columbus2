class AddSerializedPointsToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :points, :text
  end
end
