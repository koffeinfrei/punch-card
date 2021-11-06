require "../input_action"

class InputAction
  class StartInputAction < InputAction
    def matches?
      input.starts_with?("start ")
    end

    def run
      time = input.split(" ").last
      Store.new.insert(Store::EntryType::Start, DateParser.parse(time))
    end
  end
end
