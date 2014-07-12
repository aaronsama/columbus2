class AddSerializedPointsToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :points, :blob
  end
end
