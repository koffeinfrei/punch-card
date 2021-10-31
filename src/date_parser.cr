require "./i18n"

class DateParser
  def self.parse(value)
    now = Time.local

    return now if value.in?(["now", "today"])
    return (now - 1.day) if value == "yesterday"

    return Time.parse_local(value, I18n::Format.get("day_short")) rescue nil

    begin
      time = Time.parse_local(value, I18n::Format.get("time"))
      Time.local(now.year, now.month, now.day, time.hour, time.minute)
    rescue
    end

    raise "The input value '#{value}' is not an understood date format"
  end
end
