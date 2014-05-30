class AddFileToTrack < ActiveRecord::Migration
  def up
    add_attachment :tracks, :track
  end

  def down
    remove_attachment :tracks, :track
  end
end
