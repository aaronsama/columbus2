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

  def duration
    last.time - first.time
  end

  def max_speed
    range.each { |i| self[i].speed }.max
  end

end

