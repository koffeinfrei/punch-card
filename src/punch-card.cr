require "cli"
require "tablo"

require "./store"
require "./date_parser"
require "./store/entry_type"
require "./day_summary"
require "./day_table_output"
require "./month_table_output"
require "./date_formatter"
require "./input_action_parser"

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
    action.run
  end
end

PunchCard.run(ARGV)
