require "./entry"

class DaySummary
  def initialize(@entries : Array(Entry))
  end

  def to_s
    # TODO wording
    return "Not finished" if @entries.size.odd?

    @entries.in_groups_of(2).sum { |(from, to)|
      return Time::Span.new if from.nil? || to.nil?

      to.time - from.time
    }
  end
end
