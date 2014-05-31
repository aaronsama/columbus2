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

  private

  def get comparison, method
    current = self[0].send(method) # initialize max or min to the first value in the file
    range.each do |i|
      current = self[i].send(method) if self[i].send(method).send(comparison, current)
    end
    current
  end

end

