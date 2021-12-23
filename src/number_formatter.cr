class NumberFormatter
  getter number

  def initialize(@number : Float64)
  end

  def as_time
    abs_number = number.abs
    hours = abs_number.to_i
    minutes = abs_number - hours

    "#{hours}:#{(60 * minutes).round.to_i.to_s.rjust(2, '0')}"
  end

  def as_prefixed_time
    prefix =
      case number
      when .positive?
        "+"
      when .negative?
        "-"
      end

    "#{prefix}#{as_time}"
  end
end
