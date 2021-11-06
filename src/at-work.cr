require "cli"
require "tablo"

require "./store"
require "./date_parser"
require "./entry_type"
require "./day_summary"
require "./day_table_output"
require "./month_table_output"
require "./date_formatter"

class AtWork < Cli::Supercommand
  HELP_FOOTER = "Made with ☕️  by Koffeinfrei"

  version {{ `shards version #{__DIR__}`.chomp.stringify }}

  class Options
    help
    version
  end

  class Help
    header "Simple CLI to track your work time."
    footer HELP_FOOTER
  end

  class Start < Cli::Command
    class Options
      arg "start",
        required: true,
        desc: "The time you start working. Can be 'now' or a specific time like '08:15'"
      help
    end

    class Help
      header "Adds a start time entry"
      footer HELP_FOOTER
    end

    def run
      Store.new.insert(EntryType::Start, DateParser.parse(args.start))
    end
  end

  class Stop < Cli::Command
    class Options
      arg "stop",
        required: true,
        desc: "The time you stop working. Can be 'now' or a specific time like '17:30'"
      help
    end

    class Help
      header "Adds a stop time entry"
      footer HELP_FOOTER
    end

    def run
      Store.new.insert(EntryType::Stop, DateParser.parse(args.stop))
    end
  end

  class Span < Cli::Command
    class Options
      arg "span",
        required: true,
        desc: "Enter a time span. Must be in the format '<from>-<to>'. <from> and <to> can be 'now' or a specific time like '17:30'"
      help
    end

    class Help
      header "Adds a span (start-stop) time entry"
      footer HELP_FOOTER
    end

    def run
      start, stop = args.span.split("-")

      store = Store.new
      store.insert(EntryType::Start, DateParser.parse(start))
      store.insert(EntryType::Stop, DateParser.parse(stop))
    end
  end

  class Show < Cli::Command
    class Options
      arg "date",
        required: true,
        desc: "The date for which to show a summary. Can be 'today', 'yesterday', 'month' or a specific date like '#{DateFormatter.new(Time.local).day_short}'"
      help
    end

    class Help
      header "Outputs a summary of your tracked time"
      footer HELP_FOOTER
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

        puts MonthTableOutput.new(day_summary_entries).render
      else
        date = DateParser.parse(args.date)

        raw_entries = Store.new.select(date)
        day_summary_entry = DaySummary.new(date, raw_entries).get

        puts DayTableOutput.new(day_summary_entry).render
      end
    end
  end
end

AtWork.run(ARGV)
