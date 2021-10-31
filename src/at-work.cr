require "cli"
require "tablo"

require "./store"
require "./date_parser"
require "./entry_type"
require "./day_summary"
require "./day_table_output"
require "./month_table_output"
require "./date_formatter"

HELP_FOOTER = "Made with ☕️  by Koffeinfrei"

class AtWork < Cli::Supercommand
  class Start < Cli::Command
    class Options
      arg "start",
        required: true,
        desc: "The time you start working. Can be 'now' or a specific time like '08:15'"
    end

    def run
      store = Store.new
      store.create_database
      store.insert(EntryType::Start, DateParser.parse(args.start))
    end
  end

  class Stop < Cli::Command
    class Options
      arg "stop",
        required: true,
        desc: "The time you stop working. Can be 'now' or a specific time like '17:30'"
    end

    def run
      store = Store.new
      store.create_database
      store.insert(EntryType::Stop, DateParser.parse(args.stop))
    end
  end

  class Show < Cli::Command
    class Options
      arg "date",
        required: true,
        desc: "The date for which to show a summary. Can be 'today', 'yesterday', 'month' or a specific date like '2021-10-26'"
    end

    def run
      if args.date == "month"
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

        MonthTableOutput.new(day_summary_entries).render
      else
        date = DateParser.parse(args.date)

        raw_entries = Store.new.select(date)
        day_summary_entry = DaySummary.new(date, raw_entries).get

        DayTableOutput.new(day_summary_entry).render
      end
    end
  end
end

AtWork.run(ARGV)
