class NumberFormatter
  getter number

  def initialize(@number : Float64)
  end

  def rounded
    number.format(decimal_places: 2)
  end

  def rounded_and_prefixed
    if number.positive?
      "+#{rounded}"
    else
      rounded
    end
  end
end
