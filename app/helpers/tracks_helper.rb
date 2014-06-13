module TracksHelper
  def basename path
    File.basename path
  end

  def format_duration t
    t ? Time.at(t).utc.strftime("%H:%M:%S") : ""
  end

end
