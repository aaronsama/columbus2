require 'v900track/v900track'
require 'v900track/v900waypoint'

class Track < ActiveRecord::Base
  has_attached_file :track
  attr_accessible :description, :end_location, :start_location, :title, :track

  do_not_validate_attachment_file_type :track
  validates_attachment :track, :presence => true

  after_save :reverse_geocode

  def reverse_geocode
    data = V900Track.new(self.track.path)
      
    update_column(:start_location, Geocoder.address(data.first.lat_lon))
    update_column(:end_location, Geocoder.address(data.last.lat_lon))

    cache_statistics data
  end

  # store all statistics about a track
  def cache_statistics data
    [:start_date, :duration, :distance, :min_speed, :max_speed, :min_height, :max_height].each do |symbol|
      update_column(symbol, data.send(symbol))
    end
  end


  # import all the files in a specific directory.
  # useful from the command line
  def self.import dir_or_files
    # return an array of absolute pathames (this is why we run map on the dir command
    files = File.directory?(dir_or_files) ? Dir.foreach(dir_or_files).map { |filename| File.join(dir_or_files, filename) } : Dir.glob(dir_or_files)

    files.each do |filename|
      if File.extname(filename).downcase == ".csv" then
        Track.create(:track => File.open(filename, 'rb'))
      end
    end
  end

end
