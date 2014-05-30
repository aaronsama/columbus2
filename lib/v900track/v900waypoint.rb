# a facade which presents a CSV::row as a v900 waypoint
class V900Waypoint
  def initialize row
    @row = row
  end

  def index
    @row["INDEX"].to_i
  end

  def tag
    @row["TAG"]
  end

  def time
    date = @row["DATE"]
    time = @row["TIME"]
    Time.parse("#{date} #{time}")
  end

  def lon
    value = @row["LONGITUDE E/W"]
    value.match(/(N|E)/) ? value[0..-2].to_d : -1 * value[0..-2].to_d
  end

  def lat
    value = @row["LATITUDE N/S"]
    value.match(/(N|E)/) ? value[0..-2].to_d : -1 * value[0..-2].to_d
  end

  # return an array with lat and lon: [lat, lon]
  def lat_lon
    [lat, lon]
  end

  def height
    @row["HEIGHT"].to_i
  end

  def speed
    @row["SPEED"].to_i
  end

  def heading
    @row["HEADING"].to_i
  end

end
