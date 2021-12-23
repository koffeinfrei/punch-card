require "../input_action"

class InputAction
  class SpanInputAction < InputAction
    def matches?
      input.includes?("-")
    end

    def run
      start, stop = input.split("-")

      store = Store.new
      store.insert(Store::EntryType::Start, DateParser.parse(start), project)
      store.insert(Store::EntryType::Stop, DateParser.parse(stop))
    end
  end
end
