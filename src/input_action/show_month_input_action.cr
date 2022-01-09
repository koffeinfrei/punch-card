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
        .map { |day|
          Time.local(year, month, day)
        }
        .map { |date|
          raw_entries = Store.new.select(date)
          DaySummary.new(date, raw_entries).get
        }
        .reject { |entry|
          (entry.day.saturday? || entry.day.sunday?) && entry.empty?
        }

      puts MonthTableOutput.new(day_summary_entries).render
    end
  end
end
