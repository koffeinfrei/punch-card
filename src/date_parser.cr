require "./i18n"

class DateParser
  def self.parse(value)
    literal = parse_literal(value)
    return literal unless literal.nil?

    date = parse_date(value)
    return date unless date.nil?

    time = parse_time(value)
    return time unless time.nil?

    raise "The input value '#{value}' is not an understood date format"
  end

  def self.parse_literal(value)
    now = Time.local

    return now if value.in?(["now", "today"])
    return (now - 1.day) if value == "yesterday"
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
end
