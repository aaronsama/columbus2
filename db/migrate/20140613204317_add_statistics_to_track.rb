class AddStatisticsToTrack < ActiveRecord::Migration
  def change
    add_column :tracks, :start_date, :datetime
    add_column :tracks, :duration, :integer

    add_column :tracks, :distance, :float

    add_column :tracks, :min_speed, :integer
    add_column :tracks, :max_speed, :integer
    
    add_column :tracks, :min_height, :integer
    add_column :tracks, :max_height, :integer
  end
end
