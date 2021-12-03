class NumberFormatter
  getter number

  def initialize(@number : Float64)
  end

  def as_time
    hours = number.to_i
    minutes = (number - hours).abs
    "#{hours}:#{(60 * minutes).round.to_i.to_s.rjust(2, '0')}"
  end

  def as_prefixed_time
    if number.positive?
      "+#{as_time}"
    else
      as_time
    end
  end
end
