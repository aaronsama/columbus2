require 'csv'
require 'v900track/v900waypoint'

class V900Track
  def initialize filename
    @data = read filename
  end

  def read filename
    @data = CSV::read(filename, :headers => true)
  end

  def size
    @data.size
  end

  def range
    (0..self.size - 1)
  end

  # iterator over the CSV
  # it decorates the output returning a Waypoint
  # todo: inefficient!?
  def each
    array = @data.each.map { |item| V900Waypoint.new(item) }
    array.each
  end

  def get i
    self[i]
  end

  def [](i)
    V900Waypoint.new(@data[i])
  end

  def first
    self[0]
  end

  def last
    self[size - 1]
  end

  # statistics

  def start_date
    first.time
  end

  def duration
    last.time - first.time
  end

  def min_speed
    get :<, :speed
  end

  def max_speed
    get :>, :speed
  end

  def min_height
    get :<, :height
  end

  def max_height
    get :>, :height
  end

  def bearing
    Geocoder::Calculations.compass_point(Geocoder::Calculations.bearing_between(first.lat_lon, last.lat_lon))
  end

  def distance_aerial
    Geocoder::Calculations.distance_between(first.lat_lon, last.lat_lon, :units => :km)
  end

  def distance
    distance = 0
    (1..self.size - 1).each do |i|
      distance += Geocoder::Calculations.distance_between(self[i].lat_lon, self[i-1].lat_lon, :units => :km)
    end
    distance
  end

  private

  def get comparison, method
    current = self[0].send(method) # initialize max or min to the first value in the file
    range.each do |i|
      current = self[i].send(method) if self[i].send(method).send(comparison, current)
    end
    current
  end

end

