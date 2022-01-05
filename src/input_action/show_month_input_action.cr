require "../input_action"

class InputAction
  class ShowMonthInputAction < InputAction
    def matches?
      DateParser::Month.parse?(input)
    end

    def run
      year, month = DateParser::Month.parse?(input) || [] of Int32

      today = Time.local
      last_day =
        if today.year == year && today.month == month
          today.day
        else
          Time.local(year, month, 1).at_end_of_month.day
        end

      day_summary_entries = (1..last_day).to_a
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
