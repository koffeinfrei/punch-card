require "../input_action"

class InputAction
  class ShowMonthInputAction < InputAction
    def matches?
      input == "month"
    end

    def run
      month = Time.local.month
      year = Time.local.year

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
