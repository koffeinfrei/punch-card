require "../input_action"

class InputAction
  class ShowMonthInputAction < InputAction
    def matches?
      DateParser::Month.parse?(input)
    end

    def run
      year, month = DateParser::Month.parse?(input) || [] of Int32

      day_summary_entries = (1..Time.local.day).to_a
        .compact_map { |day|
          date = Time.local(year, month, day)
          date unless date.saturday? || date.sunday?
        }
        .map do |date|
          raw_entries = Store.new.select(date)
          DaySummary.new(date, raw_entries).get
        end

      puts MonthTableOutput.new(day_summary_entries).render
    end
  end
end
