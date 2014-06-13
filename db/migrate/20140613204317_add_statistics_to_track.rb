class AddStatisticsToTrack < ActiveRecord::Migration
  def up
    add_column :tracks, :start_date, :datetime
    add_column :tracks, :duration, :integer

    add_column :tracks, :distance, :float

    add_column :tracks, :min_speed, :integer
    add_column :tracks, :max_speed, :integer
    
    add_column :tracks, :min_height, :integer
    add_column :tracks, :max_height, :integer

    Track.all.each do |track|
      track.cache_statistics V900Track.new(track.track.path)
    end
  end

  def down
    remove_column :tracks, :start_date
    remove_column :tracks, :duration

    remove_column :tracks, :distance

    remove_column :tracks, :min_speed
    remove_column :tracks, :max_speed
    
    remove_column :tracks, :min_height
    remove_column :tracks, :max_height
  end

end
