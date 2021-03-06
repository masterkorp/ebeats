class MainController < Controller
  def index
    beat_time = Beat::Time.now.to_beats
    @title = "eBeats Internet Time : @%s" % beat_time.beats.to_i
    @beat_date = beat_time.beat_date_string
    @beats = beat_time.beat_datetime_string
  end

  def just_beat(timespec = nil)
    respond("@%s.beats" % now_or_later(timespec).beats.to_i)
  end

  def beat(timespec = nil)
    time = now_or_later(timespec)
    respond("%s@%0.3f.beats" % [time.beat_date_string, time.beats])
  end

  def full_beat(timespec = nil)
    time = now_or_later(timespec)
    respond("%s@%s.beats" % [time.beat_date_string, time.beats])
  end

  private
  def now_or_later(timespec = nil)
    if timespec && time = Beat::Time.parse(timespec)
      time.to_beats
    else
      Beat::Time.now.to_beats
    end
  rescue
    respond "Invalid Time Specification", 400
  end
end
