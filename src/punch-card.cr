require "cli"
require "tablo"

require "./store"
require "./date_parser"
require "./store/entry_type"
require "./day_summary"
require "./day_table_output"
require "./month_table_output"
require "./date_formatter"

abstract class InputAction
  getter input

  def initialize(@input : String)
  end

  abstract def matches?
  abstract def run
end

class StartInputAction < InputAction
  def matches?
    input.starts_with?("start ")
  end

  def run
    time = input.split(" ").last
    Store.new.insert(Store::EntryType::Start, DateParser.parse(time))
  end
end

class StopInputAction < InputAction
  def matches?
    input.starts_with?("stop ")
  end

  def run
    time = input.split(" ").last
    Store.new.insert(Store::EntryType::Stop, DateParser.parse(time))
  end
end

class SpanInputAction < InputAction
  def matches?
    input.includes?("-")
  end

  def run
    start, stop = input.split("-")

    store = Store.new
    store.insert(Store::EntryType::Start, DateParser.parse(start))
    store.insert(Store::EntryType::Stop, DateParser.parse(stop))
  end
end

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

class InputActionParser
  getter input

  def initialize(@input : String)
  end

  def parse
    if StartInputAction.new(input).matches?
      StartInputAction.new(input)
    elsif StopInputAction.new(input).matches?
      StopInputAction.new(input)
    elsif SpanInputAction.new(input).matches?
      SpanInputAction.new(input)
    elsif ShowDayInputAction.new(input).matches?
      ShowDayInputAction.new(input)
    elsif ShowMonthInputAction.new(input).matches?
      ShowMonthInputAction.new(input)
    end
  end
end

class PunchCard < Cli::Command
  HELP_FOOTER = "Made with ☕️  by Koffeinfrei"

  version {{ `shards version #{__DIR__}`.chomp.stringify }}

  class Options
    arg "input",
      required: true,
      desc: <<-DESC
        The input can be any string adhering to any of the following definitions. The format implies a specific action.

        Add an entry:
          start <time>
            The time you start working
            Can be 'now' or a specific time like '#{DateFormatter.new(DateParser.parse("08:15")).time}'

          stop <time>
            The time you stop working
            Can be 'now' or a specific time like '#{DateFormatter.new(DateParser.parse("17:30")).time}'

          span <start time>-<stop time>
            A time span of work
            Must be in the format '<from>-<to>'
            <from> and <to> can be 'now' or a specific time like '#{DateFormatter.new(DateParser.parse("17:30")).time}'

        Show an entry:
          <date>
            Can be 'today', 'yesterday', 'month' or a specific date like '#{DateFormatter.new(Time.local).day_short}'
        DESC

    help
    version
  end

  class Help
    header "Simple CLI to track your work time."
    footer HELP_FOOTER
  end

  def run
    input = ([args.input] + args.nameless_args).join(" ")
    action = InputActionParser.new(input).parse
    action.run unless action.nil?
  end
end

PunchCard.run(ARGV)
