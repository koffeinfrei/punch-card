require "../input_action"
require "../date_parser"

class InputAction
  class ShowDayInputAction < InputAction
    def matches?
      !!DateParser.parse(input)
    end

    def run
      date = DateParser.parse(input)

      raw_entries = Store.new.select(date)
      day_summary_entry = DaySummary.new(date, raw_entries).get

      puts DayTableOutput.new(day_summary_entry).render
    end
  end
end
