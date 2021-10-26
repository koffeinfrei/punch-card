class DateParser
  def self.parse(value)
    hour, minute = value.split(':').map(&.to_i)
    now = Time.local
    Time.local(now.year, now.month, now.day, hour, minute)
  end
end
