require "./i18n"

class DateParser
  def self.parse(value)
    literal_date = parse_literal_date(value)
    return literal_date unless literal_date.nil?

    literal_time = parse_literal_time(value)
    return literal_time unless literal_time.nil?

    date_time = parse_date_time(value)
    return date_time unless date_time.nil?

    date = parse_date(value)
    return date unless date.nil?

    time = parse_time(value)
    return time unless time.nil?

    raise "The input value '#{value}' is not an understood date format"
  end

  def self.parse_literal_date(value)
    # omit the time part
    now = Time.local(*Time.local.date)

    return now if value == "today"
    return (now - 1.day) if value == "yesterday"
  end

  def self.parse_literal_time(value)
    now = Time.local

    return now if value == "now"
  end

  def self.parse_date(value)
    Time.parse_local(value, I18n::Format.get("day_short")) rescue nil
  end

  def self.parse_time(value)
    now = Time.local

    begin
      time = Time.parse_local(value, I18n::Format.get("time"))
      Time.local(now.year, now.month, now.day, time.hour, time.minute)
    rescue
    end
  end

  def self.parse_date_time(value)
    format = "#{I18n::Format.get("time")} #{I18n::Format.get("day_short")}"
    Time.parse_local(value, format) rescue nil
  end
end
