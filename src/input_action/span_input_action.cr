require "../input_action"

class InputAction
  class SpanInputAction < InputAction
    def matches?
      input.includes?("-")
    end

    def run
      start, stop_and_date = input.split("-")
      stop_and_date = stop_and_date.split(" ")
      stop, date = stop_and_date[0], stop_and_date[1]?

      start = [start, date].compact.join(" ")
      stop = [stop, date].compact.join(" ")

      store = Store.new
      store.insert(Store::EntryType::Start, DateParser.parse(start), project)
      store.insert(Store::EntryType::Stop, DateParser.parse(stop))
    end
  end
end
