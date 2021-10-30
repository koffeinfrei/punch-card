class DateFormatter
  DAY_SHORT = "%d.%m.%Y"
  DAY_WITH_NAME = "%a  %d.%m.%Y"
  MONTH_WITH_NAME = "%b %Y"
  TIME            = "%H:%M"

  getter date

  def initialize(@date : Time)
  end

  def day_short
    date.to_s(DAY_SHORT)
  end

  def day_with_name
    date.to_s(DAY_WITH_NAME)
  end

  def month_with_name
    date.to_s(MONTH_WITH_NAME)
  end

  def time
    date.to_s(TIME)
  end
end
