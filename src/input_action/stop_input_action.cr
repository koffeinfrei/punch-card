require "../input_action"
require "../input_action/show_day_input_action"

class InputAction
  class StopInputAction < InputAction
    def matches?
      input.starts_with?("stop ")
    end

    def run
      time = input.split(" ", limit: 2).last
      Store.new.insert(Store::EntryType::Stop, DateParser.parse(time))

      ShowDayInputAction.new(time).run
    end

    def self.description
      {
        "Add an entry",
        <<-DESC
          stop <time> [date]
              The time you stop working
              Can be 'now' or a specific time like '#{DateFormatter.new(DateParser.parse("17:30")).time}'
              The date is 'today' by default
          DESC
      }
    end
  end
end
