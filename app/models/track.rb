require 'v900track/v900track'
require 'v900track/v900waypoint'

class Track < ActiveRecord::Base
  has_attached_file :track
  attr_accessible :description, :end_location, :start_location, :title, :track, :start_date, :duration, :distance, :min_speed, :max_speed, :min_height, :max_height

  do_not_validate_attachment_file_type :track
  validates_attachment :track, :presence => true

  after_commit :reverse_geocode, on: :create

  def reverse_geocode
    data = to_a

    update_column(:start_location, Geocoder.address([data.first[:lat],data.first[:lon]]))
    update_column(:end_location, Geocoder.address([data.last[:lat],data.last[:lon]]))

    cache_statistics data
  end

  # store all statistics about a track
  def cache_statistics data
    self.start_date = DateTime.parse data.first[:timestamp]
    self.duration = DateTime.parse(data.last[:timestamp]).to_time - DateTime.parse(data.first[:timestamp]).to_time
    calculate_distance
    self.min_speed = data.map{|p| p[:speed]}.min
    self.max_speed = data.map{|p| p[:speed]}.max
    self.min_height = data.map{|p| p[:alt]}.min
    self.max_height = data.map{|p| p[:alt]}.max
    save
  end

  def to_a
    data = CSV::read self.track.path, headers: true
    data.map do |p|
      ts = "20#{p['DATE'].scan(/../).join('-')}T#{p['TIME'].scan(/../).join(':')}"
      lat = parse_lat p["LATITUDE N/S"]
      lon = parse_lon p["LONGITUDE E/W"]
      speed = p["SPEED"].to_i
      alt = p["HEIGHT"].to_i
      { timestamp: ts, lat: lat, lon: lon, speed: speed, alt: alt }
    end
  end

  def distance
    read_attribute(:distance) || calculate_distance
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

  private

  def parse_lat str
    str.last == 'N' ? str.to_f : -str.to_f
  end

  def parse_lon str
    str.last == 'E' ? str.to_f : -str.to_f
  end

  def calculate_distance
    tot = 0
    points = to_a
    points.inject(points.first) do |prev,current|
      if prev != current
        tot += Geocoder::Calculations.distance_between([prev[:lat],prev[:lon]], [current[:lat],current[:lon]], :units => :km)
      end
      current
    end
    update_attribute(:distance,tot)
    tot
  end

end
