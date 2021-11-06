struct DaySummaryEntry
  getter day, spans, sum

  def initialize(@day : Time, @spans : Array(NamedTuple(from: Time | Nil, to: Time | Nil)), @sum : Time::Span)
  end

  def sum_in_hours
    sum.total_hours
  end

  def diff_in_hours
    sum_in_hours - 8
  end

  def empty?
    spans.empty?
  end
end
