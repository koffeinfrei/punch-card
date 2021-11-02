require "./i18n"

class DateFormatter
  getter date

  def initialize(@date : Time)
  end

  def day_short
    date.to_local.to_s(I18n::Format.get("day_short"))
  end

  def day_with_name
    date.to_local.to_s(I18n::Format.get("day_with_name"))
  end

  def month_with_name
    date.to_local.to_s(I18n::Format.get("month_with_name"))
  end

  def time
    date.to_local.to_s(I18n::Format.get("time"))
  end
end
