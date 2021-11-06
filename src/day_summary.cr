require "./store/entry"
require "./day_summary_entry"

class DaySummary
  getter date, entries

  def initialize(@date : Time, @entries : Array(Store::Entry))
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
