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
  end

  # import all the files in a specific directory.
  # useful from the command line
  def self.import dirname
    Dir.foreach(dirname) do |filename|
      if File.extname(filename).downcase == ".csv" then
        Track.create(:track => File.open(File.join(dirname, filename), 'rb'))
      end
    end
  end

end
