require "../input_action"
require "../input_action/show_day_input_action"

class InputAction
  class StartInputAction < InputAction
    def matches?
      input.starts_with?("start ")
    end

    def run
      time = input.split(" ", limit: 2).last
      Store.new.insert(Store::EntryType::Start, DateParser.parse(time), project)

      ShowDayInputAction.new(time).run
    end

    def self.description
      {
        "Add an entry",
        <<-DESC
          start <time> [date]
              The time you start working
              Can be 'now' or a specific time like '#{DateFormatter.new(DateParser.parse("08:15")).time}'
              The date is 'today' by default
          DESC
      }
    end
  end
end
