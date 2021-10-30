require "./entry"

class DaySummary
  getter date, entries

  def initialize(@date : Time, @entries : Array(Entry))
  end

  def get
    # TODO wording
    # return "Not finished" if @entries.size.odd?

    # TODO check that 1st is "start", 2nd is "stop" type
    span_entries = entries.map(&.time).in_groups_of(2).map do |(from, to)|
      {from: from, to: to}
    end

    sum = span_entries.sum do |entry|
      from = entry[:from]
      to = entry[:to]

      break Time::Span.new if from.nil? || to.nil?

      to - from
    end

    DaySummaryEntry.new(date, span_entries, sum)
  end
end

struct DaySummaryEntry
  getter day, spans, sum

  def initialize(@day : Time, @spans : Array(NamedTuple(from: Time | Nil, to: Time | Nil)), @sum : Time::Span)
  end

  def sum_in_hours
    sum.total_hours
  end

  def diff_in_hours
    (sum_in_hours - 8).round(2)
  end
end
