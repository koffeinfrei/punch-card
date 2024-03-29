class NumberFormatter
  getter number

  def initialize(@number : Float64)
  end

  def as_time
    abs_number = number.abs
    hours = abs_number.to_i
    minutes = abs_number - hours

    rounded_minutes = (60 * minutes).round.to_i
    if rounded_minutes == 60
      hours += 1
      rounded_minutes = 0
    end

    "#{hours}:#{rounded_minutes.to_s.rjust(2, '0')}"
  end

  def as_prefixed_time
    prefix =
      case number
      when .positive? then "+"
      when .negative? then "-"
      end

    "#{prefix}#{as_time}"
  end
end
