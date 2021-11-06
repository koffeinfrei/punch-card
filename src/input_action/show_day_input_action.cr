require "../input_action"

class InputAction
  class ShowDayInputAction < InputAction
    def matches?
      input == "today"
    end

    def run
      date = DateParser.parse(input)

      raw_entries = Store.new.select(date)
      day_summary_entry = DaySummary.new(date, raw_entries).get

      puts DayTableOutput.new(day_summary_entry).render
    end
  end
end
