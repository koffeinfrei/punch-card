require "./store/entry"
require "./store/entry_type"
require "./day_summary_entry"

class DaySummary
  EMPTY_FORMAT      = "The 'from' entry %{from} is empty. There's something mixed up with the entries."
  WRONG_TYPE_FORMAT = "The '%{name}' entry %{entry} is not of type %{type}, although it should be"

  getter date, entries

  def initialize(@date : Time, @entries : Array(Store::Entry))
  end

  def get
    span_entries = entries.in_groups_of(2).map do |(from, to)|
      raise EMPTY_FORMAT % {from: from} if from.nil?

      from_time = from.time
      to_time = to.try(&.time)

      raise WRONG_TYPE_FORMAT % {name: "from", entry: from, type: Store::EntryType::Start} if from.type != Store::EntryType::Start
      raise WRONG_TYPE_FORMAT % {name: "to", entry: to, type: Store::EntryType::Stop} if to && to.type != Store::EntryType::Stop

      {
        from: {
          time: from_time, draft: from.id.nil?,
        },
        to: {
          time: to_time, draft: to.try(&.id).nil?,
        },
        project: from.project,
      }
    end

    sum = span_entries.sum do |entry|
      from = entry[:from][:time]
      to = entry[:to]?.try(&.[:time])

      if to
        to - from
      else
        Time::Span.new
      end
    end

    DaySummaryEntry.new(date, span_entries, sum)
  end
end
