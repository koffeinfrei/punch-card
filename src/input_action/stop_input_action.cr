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

      ShowDayInputAction.new("today").run
    end
  end
end
