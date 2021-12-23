struct DaySummaryEntry
  getter day, spans, sum

  def initialize(
    @day : Time,
    @spans : Array(NamedTuple(
      from: Time,
      to: Time | Nil,
      project: String | Nil)),
    @sum : Time::Span
  )
  end

  def sum_in_hours
    sum.total_hours
  end

  def diff_in_hours
    sum_in_hours - 8
  end

  def projects
    spans.map(&.[:project])
  end

  def empty?
    spans.empty?
  end
end
