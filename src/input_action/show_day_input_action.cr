require "../input_action"
require "../date_parser"

class InputAction
  class ShowDayInputAction < InputAction
    def matches?
      DateParser.parse_date(input) || DateParser.parse_literal_date(input)
    end

    def run
      date = DateParser.parse(input)

      raw_entries = Store.new.select(date)
      day_summary_entry = DaySummary.new(date, raw_entries).get

      puts DayTableOutput.new(day_summary_entry).render
    end

    def self.description
      {
        "Show a day's entries",
        <<-DESC
          <date>
              Can be 'today', 'yesterday' or a specific date like '#{DateFormatter.new(Time.local).day_short}'
          DESC
      }
    end
  end
end
