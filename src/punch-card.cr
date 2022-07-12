require "cli"
require "tablo"
require "colorize"

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
    descriptions = InputAction.available_actions.compact_map { |input_action|
      input_action.description
    }
      .sort! { |a, b| a.first <=> b.first }
      .group_by(&.first)
      .map { |(group, entries)|
        "#{group}:\n" +
          entries.map(&.last).map { |entry| "  #{entry}" }.join("\n\n")
      }.join("\n\n")

    arg "input",
      required: true,
      desc: <<-DESC
        The input can be any string adhering to any of the following definitions. The format implies a specific action.

        #{descriptions}
        DESC

    string %w(-p --project),
      required: false,
      desc: "An optional project"

    help
    version
  end

  class Help
    header "Simple CLI to track your work time."
    footer HELP_FOOTER
  end

  def run
    input = ([args.input] + args.nameless_args).join(" ")
    action = InputActionParser.parse(input, args.project?)
    action.run
  rescue e
    STDERR.puts e.message.colorize(:red)
    {% unless flag?(:release) %}
      puts "\n__DEBUG DEV OUTPUT__\n\n"
      raise e
    {% end %}
  end
end

PunchCard.run(ARGV)
