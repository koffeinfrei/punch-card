struct DaySummaryEntry
  HOURS_PER_DAY = {
    Time::DayOfWeek::Monday    => 8,
    Time::DayOfWeek::Tuesday   => 8,
    Time::DayOfWeek::Wednesday => 8,
    Time::DayOfWeek::Thursday  => 8,
    Time::DayOfWeek::Friday    => 8,
    Time::DayOfWeek::Saturday  => 0,
    Time::DayOfWeek::Sunday    => 0,
  }

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
    sum_in_hours - HOURS_PER_DAY[@day.day_of_week]
  end

  def projects
    spans.map(&.[:project])
  end

  def empty?
    spans.empty?
  end
end
